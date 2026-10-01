import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/journal_repository.dart';
import '../../data/providers.dart';
import 'journal_detail_screen.dart';
import 'journal_form_screen.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});
  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  JournalFilter _filter = JournalFilter.open;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(journalByFilter(_filter));
    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add entry',
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const JournalFormScreen())),
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SegmentedButton<JournalFilter>(
            segments: const [
              ButtonSegment(value: JournalFilter.open, label: Text('Open')),
              ButtonSegment(value: JournalFilter.due, label: Text('Due for review')),
              ButtonSegment(value: JournalFilter.reviewed, label: Text('Reviewed')),
            ],
            selected: {_filter},
            onSelectionChanged: (s) => setState(() => _filter = s.first),
          ),
        ),
        Expanded(
          child: items.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (list) => list.isEmpty
                ? const Padding(padding: EdgeInsets.all(16), child: EmptyLine('Nothing here'))
                : ListView(children: [
                    for (final e in list)
                      ListTile(
                        title: Text(e.decision),
                        subtitle: Text('Review ${e.reviewDate} · ${e.confidence}%'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => JournalDetailScreen(id: e.id)),
                        ),
                      ),
                  ]),
          ),
        ),
      ]),
    );
  }
}
