import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers.dart';
import 'dates.dart';
import 'rules.dart';

class EmptyLine extends StatelessWidget {
  const EmptyLine(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text, style: TextStyle(color: Theme.of(context).hintColor)),
      );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 4),
        child: Row(children: [
          Expanded(child: Text(text, style: Theme.of(context).textTheme.titleMedium)),
          ?trailing,
        ]),
      );
}

Future<bool> confirm(BuildContext context, String message, {String action = 'Confirm'}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (c) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(c, true), child: Text(action)),
      ],
    ),
  );
  return ok ?? false;
}

void showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

class ConfidenceField extends StatelessWidget {
  const ConfidenceField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Confidence',
    this.helper,
  });
  final int value;
  final ValueChanged<int>? onChanged;
  final String label;
  final String? helper;
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<int>(
        initialValue: value,
        decoration: InputDecoration(labelText: label, helperText: helper),
        items: [
          for (final c in confidenceChoices) DropdownMenuItem(value: c, child: Text('$c%')),
        ],
        onChanged: onChanged == null ? null : (v) => onChanged!(v ?? defaultConfidence),
      );
}

class TagField extends ConsumerWidget {
  const TagField({super.key, required this.value, required this.onChanged});
  final int? value;
  final ValueChanged<int?> onChanged;

  static const _newTag = -1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider).value ?? const [];
    return DropdownButtonFormField<int?>(
      initialValue: tags.any((t) => t.id == value) ? value : null,
      decoration: const InputDecoration(labelText: 'Tag (optional)'),
      items: [
        const DropdownMenuItem(value: null, child: Text('No tag')),
        for (final t in tags) DropdownMenuItem(value: t.id, child: Text(t.name)),
        const DropdownMenuItem(value: _newTag, child: Text('New tag…')),
      ],
      onChanged: (v) async {
        if (v != _newTag) return onChanged(v);
        final name = await promptText(context, 'New tag');
        if (name == null) return;
        try {
          onChanged(await ref.read(tagRepoProvider).add(name));
        } catch (_) {
          if (context.mounted) showMessage(context, 'That tag already exists');
        }
      },
    );
  }
}

Future<String?> promptText(BuildContext context, String title, {String? initial}) async {
  final c = TextEditingController(text: initial);
  final r = await showDialog<String>(
    context: context,
    builder: (d) => AlertDialog(
      title: Text(title),
      content: TextField(controller: c, autofocus: true),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(d, c.text.trim()), child: const Text('OK')),
      ],
    ),
  );
  return r == null || r.isEmpty ? null : r;
}

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    this.helper,
  });
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final DateTime firstDate;
  final String? helper;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          final current = parseYmd(value);
          final d = await showDatePicker(
            context: context,
            initialDate: current.isBefore(firstDate) ? firstDate : current,
            firstDate: firstDate,
            lastDate: DateTime(2100),
          );
          if (d != null) onChanged(ymd(d));
        },
        child: InputDecorator(
          decoration: InputDecoration(labelText: label, helperText: helper),
          child: Text(value),
        ),
      );
}

String outcomeLabel(String? o) => switch (o) {
      'true' => 'True',
      'false' => 'False',
      'void' => 'Void',
      _ => 'Open',
    };
