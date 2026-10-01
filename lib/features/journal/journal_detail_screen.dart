import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/journal_repository.dart';
import '../../data/providers.dart';
import 'journal_form_screen.dart';
import 'journal_review_screen.dart';

class JournalDetailScreen extends ConsumerWidget {
  const JournalDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Rebuild whenever entries, reviews or predictions change.
    ref.watch(allJournalProvider);
    ref.watch(allReviewsProvider);
    ref.watch(allPredictionsProvider);
    return FutureBuilder<JournalDetail>(
      future: ref.read(journalRepoProvider).detail(id),
      builder: (context, snap) {
        final d = snap.data;
        if (d == null) return Scaffold(appBar: AppBar());
        final e = d.entry;
        final tags = ref.watch(tagsProvider).value ?? const [];
        final tag = tags.where((t) => t.id == e.tagId).firstOrNull;
        final choice = d.options.where((o) => o.id == e.choiceOptionId).firstOrNull;
        return Scaffold(
          appBar: AppBar(title: const Text('Journal entry'), actions: [
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => JournalFormScreen(existing: d))),
            ),
          ]),
          body: ListView(padding: const EdgeInsets.all(16), children: [
            Text(e.decision, style: Theme.of(context).textTheme.titleLarge),
            if (e.context != null) ...[const SectionHeader('Context'), Text(e.context!)],
            const SectionHeader('Options considered'),
            for (final o in d.options)
              Text('${o.id == choice?.id ? '● ' : '○ '}${o.body}'),
            const SectionHeader('Reasoning'),
            Text(e.reasoning),
            const SectionHeader('Expected outcome'),
            Text('${e.expectedOutcome} (${e.confidence}%)'),
            const SizedBox(height: 8),
            if (tag != null) Text('Tag: ${tag.name}'),
            Text('Review date: ${e.reviewDate}'),
            if (d.prediction != null)
              Text('Linked prediction: ${outcomeLabel(d.prediction!.outcome)}'),
            const SectionHeader('Review'),
            if (d.review == null) ...[
              const EmptyLine('Not reviewed yet'),
              Wrap(spacing: 8, children: [
                FilledButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JournalReviewScreen(detail: d))),
                  child: const Text('Review now'),
                ),
                OutlinedButton(
                  onPressed: () => _postpone(context, ref, e.reviewDate),
                  child: const Text('Postpone'),
                ),
              ]),
            ] else ...[
              Text('What happened: ${d.review!.whatHappened}'),
              Text('Reasoning soundness: ${d.review!.reasoningScore}/5'),
              if (d.review!.lessons != null) Text('Lessons: ${d.review!.lessons}'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => JournalReviewScreen(detail: d))),
                child: const Text('Edit review'),
              ),
            ],
          ]),
        );
      },
    );
  }

  Future<void> _postpone(BuildContext context, WidgetRef ref, String current) async {
    final from = parseYmd(current);
    final d = await showDatePicker(
      context: context,
      initialDate: from.add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (d != null) await ref.read(journalRepoProvider).postpone(id, ymd(d));
  }
}
