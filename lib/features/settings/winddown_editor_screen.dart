import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';

class WinddownEditorScreen extends ConsumerWidget {
  const WinddownEditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(windDownStepsProvider).value ?? const [];
    final repo = ref.read(winddownRepoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Wind-down routine')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add step',
        onPressed: () => _edit(context, ref, null),
        child: const Icon(Icons.add),
      ),
      body: steps.isEmpty
          ? const Padding(padding: EdgeInsets.all(16), child: EmptyLine('No steps yet'))
          : ReorderableListView(
              onReorderItem: (from, to) => repo.move(steps[from].id, to),
              children: [
                for (final s in steps)
                  ListTile(
                    key: ValueKey(s.id),
                    title: Text(s.name),
                    subtitle: Text(s.minutes == null ? 'No timer' : '${s.minutes} min'),
                    onTap: () => _edit(context, ref, s),
                    trailing: IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => repo.deleteStep(s.id),
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, WinddownStep? step) async {
    final name = TextEditingController(text: step?.name);
    final minutes = TextEditingController(text: step?.minutes?.toString());
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(step == null ? 'Add step' : 'Edit step'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Name')),
          TextField(
            controller: minutes,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Minutes (optional)'),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true || name.text.trim().isEmpty) return;
    final m = int.tryParse(minutes.text.trim());
    final repo = ref.read(winddownRepoProvider);
    if (step == null) {
      await repo.addStep(name.text, m);
    } else {
      await repo.updateStep(step.id, name.text, m);
    }
  }
}
