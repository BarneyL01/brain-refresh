import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/providers.dart';

class TagsScreen extends ConsumerWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(tagsProvider).value ?? const [];
    final repo = ref.read(tagRepoProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Tags')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add tag',
        onPressed: () async {
          final name = await promptText(context, 'New tag');
          if (name == null) return;
          try {
            await repo.add(name);
          } catch (_) {
            if (context.mounted) showMessage(context, 'That tag already exists');
          }
        },
        child: const Icon(Icons.add),
      ),
      body: tags.isEmpty
          ? const Padding(padding: EdgeInsets.all(16), child: EmptyLine('No tags'))
          : ListView(children: [
              for (final t in tags)
                ListTile(
                  title: Text(t.name),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      tooltip: 'Rename',
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final name = await promptText(context, 'Rename tag', initial: t.name);
                        if (name == null) return;
                        try {
                          await repo.rename(t.id, name);
                        } catch (_) {
                          if (context.mounted) showMessage(context, 'That tag already exists');
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        if (!await repo.deleteIfUnused(t.id) && context.mounted) {
                          showMessage(context, 'Only unused tags can be deleted');
                        }
                      },
                    ),
                  ]),
                ),
            ]),
    );
  }
}
