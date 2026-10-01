import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/rules.dart';
import '../../core/widgets.dart';
import '../../data/journal_repository.dart';
import '../../data/providers.dart';

class JournalFormScreen extends ConsumerStatefulWidget {
  const JournalFormScreen({super.key, this.existing});
  final JournalDetail? existing;
  @override
  ConsumerState<JournalFormScreen> createState() => _JournalFormScreenState();
}

class _JournalFormScreenState extends ConsumerState<JournalFormScreen> {
  final _form = GlobalKey<FormState>();
  late final _decision = TextEditingController(text: widget.existing?.entry.decision);
  late final _context = TextEditingController(text: widget.existing?.entry.context);
  late final _reasoning = TextEditingController(text: widget.existing?.entry.reasoning);
  late final _expected = TextEditingController(text: widget.existing?.entry.expectedOutcome);
  late final List<TextEditingController> _options = widget.existing != null
      ? [for (final o in widget.existing!.options) TextEditingController(text: o.body)]
      : [TextEditingController(), TextEditingController()];
  late int _choice = () {
    final e = widget.existing;
    if (e == null) return 0;
    final i = e.options.indexWhere((o) => o.id == e.entry.choiceOptionId);
    return i < 0 ? 0 : i;
  }();
  late int _confidence = widget.existing?.entry.confidence ?? defaultConfidence;
  late int? _tagId = widget.existing?.entry.tagId;
  late String _reviewDate =
      widget.existing?.entry.reviewDate ?? ymd(addMonths(DateTime.now(), 1));
  bool _addAsPrediction = false;

  bool get _editing => widget.existing != null;
  bool get _locked =>
      _editing && isLocked(widget.existing!.entry.createdAt, DateTime.now());

  List<String> get _optionTexts =>
      _options.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    if (_optionTexts.length < 2) {
      showMessage(context, 'Add at least 2 options');
      return;
    }
    final repo = ref.read(journalRepoProvider);
    final nonEmpty = [
      for (var i = 0; i < _options.length; i++)
        if (_options[i].text.trim().isNotEmpty) i,
    ];
    final choiceIndex = nonEmpty.indexOf(_choice).clamp(0, nonEmpty.length - 1);
    if (_editing) {
      await repo.update(
        widget.existing!.entry.id,
        decision: _decision.text,
        context: _context.text,
        options: _optionTexts,
        choiceIndex: choiceIndex,
        reasoning: _reasoning.text,
        expectedOutcome: _expected.text,
        confidence: _confidence,
        tagId: _tagId,
        reviewDate: _reviewDate,
      );
    } else {
      await repo.create(
        decision: _decision.text,
        context: _context.text,
        options: _optionTexts,
        choiceIndex: choiceIndex,
        reasoning: _reasoning.text,
        expectedOutcome: _expected.text,
        confidence: _confidence,
        tagId: _tagId,
        reviewDate: _reviewDate,
        addAsPrediction: _addAsPrediction,
      );
    }
    if (mounted) Navigator.pop(context);
  }

  String? _required(String? v) => (v ?? '').trim().isEmpty ? 'Required' : null;

  @override
  Widget build(BuildContext context) {
    final choiceItems = [
      for (var i = 0; i < _options.length; i++)
        if (_options[i].text.trim().isNotEmpty)
          DropdownMenuItem(value: i, child: Text(_options[i].text.trim())),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(_editing ? 'Edit entry' : 'New entry')),
      body: Form(
        key: _form,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(
            controller: _decision,
            decoration: const InputDecoration(labelText: 'Decision'),
            validator: _required,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _context,
            minLines: 2,
            maxLines: 5,
            decoration: const InputDecoration(
                labelText: 'Context (optional)', helperText: 'What was known at the time'),
          ),
          const SectionHeader('Options considered'),
          for (var i = 0; i < _options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _options[i],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                  ),
                ),
                if (_options.length > 2)
                  IconButton(
                    tooltip: 'Remove option',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _options.removeAt(i).dispose();
                      _choice = 0;
                    }),
                  ),
              ]),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() => _options.add(TextEditingController())),
              icon: const Icon(Icons.add),
              label: const Text('Add option'),
            ),
          ),
          DropdownButtonFormField<int>(
            key: ValueKey(choiceItems.length),
            initialValue: choiceItems.any((d) => d.value == _choice) ? _choice : null,
            decoration: const InputDecoration(labelText: 'Choice'),
            items: choiceItems,
            onChanged: (v) => setState(() => _choice = v ?? 0),
            validator: (v) => v == null ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _reasoning,
            enabled: !_locked,
            minLines: 2,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: 'Reasoning',
              helperText: _locked ? 'Locked 24 hours after creation' : null,
            ),
            validator: _required,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _expected,
            decoration: const InputDecoration(labelText: 'Expected outcome'),
            validator: _required,
          ),
          const SizedBox(height: 16),
          ConfidenceField(
            value: _confidence,
            label: 'Confidence the expected outcome happens',
            onChanged: _locked ? null : (v) => setState(() => _confidence = v),
          ),
          const SizedBox(height: 16),
          TagField(value: _tagId, onChanged: (v) => setState(() => _tagId = v)),
          const SizedBox(height: 16),
          DateField(
            label: 'Review date',
            value: _reviewDate,
            firstDate: DateTime.now(),
            onChanged: (v) => setState(() => _reviewDate = v),
          ),
          if (!_editing)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Add as prediction'),
              subtitle: const Text('Creates a linked prediction from the expected outcome'),
              value: _addAsPrediction,
              onChanged: (v) => setState(() => _addAsPrediction = v),
            ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ]),
      ),
    );
  }
}
