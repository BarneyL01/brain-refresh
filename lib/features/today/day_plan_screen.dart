import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/providers.dart';

class DayPlanScreen extends ConsumerStatefulWidget {
  const DayPlanScreen({super.key, required this.date});
  final String date;
  @override
  ConsumerState<DayPlanScreen> createState() => _DayPlanScreenState();
}

class _DayPlanScreenState extends ConsumerState<DayPlanScreen> {
  final _tasks = List.generate(3, (_) => TextEditingController());
  final _labels = <TextEditingController>[];
  final _choices = <TextEditingController>[];
  List<String> _known = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(dayPlanRepoProvider);
    final plan = await repo.get(widget.date);
    final known = await repo.knownLabels();
    setState(() {
      _known = known;
      if (plan != null) {
        for (var i = 0; i < plan.tasks.length && i < 3; i++) {
          _tasks[i].text = plan.tasks[i].body;
        }
        for (final d in plan.defaults) {
          _labels.add(TextEditingController(text: d.label));
          _choices.add(TextEditingController(text: d.choice));
        }
      }
      _loaded = true;
    });
  }

  void _addDefault([String label = '']) => setState(() {
        _labels.add(TextEditingController(text: label));
        _choices.add(TextEditingController());
      });

  Future<void> _save() async {
    await ref.read(dayPlanRepoProvider).save(
      widget.date,
      tasks: _tasks.map((c) => c.text).toList(),
      defaults: [
        for (var i = 0; i < _labels.length; i++)
          (label: _labels[i].text, choice: _choices[i].text),
      ],
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final used = _labels.map((c) => c.text.trim()).toSet();
    final quick = _known.where((l) => !used.contains(l)).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Plan for ${widget.date}')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(padding: const EdgeInsets.all(16), children: [
              const SectionHeader('Top 3 tasks'),
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _tasks[i],
                    decoration: InputDecoration(labelText: 'Task ${i + 1}'),
                  ),
                ),
              const SectionHeader('Evening defaults'),
              if (quick.isNotEmpty)
                Wrap(spacing: 8, children: [
                  for (final l in quick)
                    ActionChip(label: Text(l), onPressed: () => _addDefault(l)),
                ]),
              for (var i = 0; i < _labels.length; i++)
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: _labels[i],
                      decoration: const InputDecoration(labelText: 'Label'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _choices[i],
                      decoration: const InputDecoration(labelText: 'Choice'),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _labels.removeAt(i).dispose();
                      _choices.removeAt(i).dispose();
                    }),
                  ),
                ]),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addDefault,
                  icon: const Icon(Icons.add),
                  label: const Text('Add default'),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _save, child: const Text('Save plan')),
            ]),
    );
  }
}
