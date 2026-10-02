import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/providers.dart';
import 'experience_calc.dart';
import 'navigation.dart';

class ExperienceFormScreen extends ConsumerStatefulWidget {
  const ExperienceFormScreen({super.key});
  @override
  ConsumerState<ExperienceFormScreen> createState() =>
      _ExperienceFormScreenState();
}

class _ExperienceFormScreenState extends ConsumerState<ExperienceFormScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _participants = <TextEditingController>[];
  String _start = todayYmd();
  String? _end;
  String _frequency = 'daily';
  bool _offeredSimilar = false;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final repo = ref.read(experienceRepoProvider);
    if (!_offeredSimilar) {
      final similar = await repo.similarEarlier(_name.text);
      if (similar.isNotEmpty && mounted) {
        _offeredSimilar = true;
        final earlier = similar.first;
        final view = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            content: Text(
              'You logged ${earlier.name}. View how it went before you plan?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: const Text('Skip'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: const Text('View'),
              ),
            ],
          ),
        );
        if (view == true && mounted) {
          openExperience(context, earlier);
          return; // Back here afterwards; Save again to create.
        }
      }
    }
    try {
      await repo.create(
        name: _name.text,
        startDate: _start,
        endDate: _end,
        frequency: _frequency,
        participants: _participants.map((c) => c.text).toList(),
      );
    } on ArgumentError catch (e) {
      if (mounted) showMessage(context, '${e.message}');
      return;
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New experience')),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Name',
              helperText: 'e.g. Family camping trip 2026',
            ),
            validator: (v) => (v ?? '').trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          DateField(
            label: 'Start date',
            value: _start,
            firstDate: DateTime(2000),
            onChanged: (v) => setState(() {
              _start = v;
              if (_end != null && _end!.compareTo(v) < 0) _end = null;
            }),
          ),
          const SizedBox(height: 16),
          if (_end == null)
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.event),
                label: const Text('Set expected end date (optional)'),
                onPressed: () async {
                  final s = parseYmd(_start);
                  final d = await showDatePicker(
                    context: context,
                    initialDate: s,
                    firstDate: s,
                    lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _end = ymd(d));
                },
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: DateField(
                    label: 'Expected end date',
                    value: _end!,
                    firstDate: parseYmd(_start),
                    onChanged: (v) => setState(() => _end = v),
                  ),
                ),
                IconButton(
                  tooltip: 'Clear end date',
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _end = null),
                ),
              ],
            ),
          const SectionHeader('Check-in frequency'),
          SegmentedButton<String>(
            segments: [
              for (final f in frequencies.entries)
                ButtonSegment(value: f.key, label: Text(f.value)),
            ],
            selected: {_frequency},
            onSelectionChanged: (s) => setState(() => _frequency = s.first),
          ),
          const SectionHeader('Participants (optional)'),
          const Text(
            'Each person gets their own rating on every check-in. '
            'You can enter ratings for people who do not use the app.',
          ),
          for (var i = 0; i < _participants.length; i++)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _participants[i],
                    decoration: InputDecoration(labelText: 'Person ${i + 1}'),
                  ),
                ),
                IconButton(
                  tooltip: 'Remove',
                  icon: const Icon(Icons.close),
                  onPressed: () =>
                      setState(() => _participants.removeAt(i).dispose()),
                ),
              ],
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () =>
                  setState(() => _participants.add(TextEditingController())),
              icon: const Icon(Icons.person_add),
              label: const Text('Add person'),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _save, child: const Text('Create')),
        ],
      ),
    ),
  );
}
