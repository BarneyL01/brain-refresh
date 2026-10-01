import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import 'prediction_form_screen.dart';

class PredictionDetailScreen extends ConsumerWidget {
  const PredictionDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref
        .watch(allPredictionsProvider)
        .value
        ?.where((x) => x.id == id)
        .firstOrNull;
    if (p == null) return Scaffold(appBar: AppBar());
    final repo = ref.read(predictionRepoProvider);
    final tags = ref.watch(tagsProvider).value ?? const [];
    final tag = tags.where((t) => t.id == p.tagId).firstOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Prediction'), actions: [
        IconButton(
          tooltip: 'Edit',
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => PredictionFormScreen(existing: p))),
        ),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(p.statement, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text('Confidence: ${p.confidence}%'),
        Text('Resolve by: ${p.resolveBy}'),
        if (tag != null) Text('Tag: ${tag.name}'),
        Text('Status: ${outcomeLabel(p.outcome)}'),
        if (p.journalEntryId != null) const Text('Linked to a journal entry'),
        const SizedBox(height: 16),
        if (p.outcome == null) ...[
          const SectionHeader('Resolve'),
          Wrap(spacing: 8, children: [
            for (final o in const ['true', 'false', 'void'])
              FilledButton.tonal(
                onPressed: () => repo.resolve(p.id, o),
                child: Text(outcomeLabel(o)),
              ),
          ]),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => _extend(context, ref, p),
            child: const Text('Extend resolve-by date'),
          ),
        ] else
          OutlinedButton(
            onPressed: () => repo.reopen(p.id),
            child: const Text('Reopen'),
          ),
        const SectionHeader('Date history'),
        FutureBuilder<List<PredictionDateChange>>(
          key: ValueKey(p.resolveBy),
          future: repo.history(p.id),
          builder: (c, s) {
            final h = s.data ?? const [];
            if (h.isEmpty) return const EmptyLine('No extensions');
            return Column(children: [
              for (final c in h)
                ListTile(
                  dense: true,
                  title: Text('${c.oldDate} → ${c.newDate}'),
                  subtitle: Text(ymd(c.createdAt)),
                ),
            ]);
          },
        ),
      ]),
    );
  }

  Future<void> _extend(BuildContext context, WidgetRef ref, Prediction p) async {
    final current = parseYmd(p.resolveBy);
    final d = await showDatePicker(
      context: context,
      initialDate: current.add(const Duration(days: 1)),
      firstDate: current.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (d != null) await ref.read(predictionRepoProvider).extendDate(p.id, ymd(d));
  }
}
