import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets.dart';
import '../../data/journal_repository.dart';
import '../../data/providers.dart';

class JournalReviewScreen extends ConsumerStatefulWidget {
  const JournalReviewScreen({super.key, required this.detail});
  final JournalDetail detail;
  @override
  ConsumerState<JournalReviewScreen> createState() => _JournalReviewScreenState();
}

class _JournalReviewScreenState extends ConsumerState<JournalReviewScreen> {
  final _form = GlobalKey<FormState>();
  late final _what = TextEditingController(text: widget.detail.review?.whatHappened);
  late final _lessons = TextEditingController(text: widget.detail.review?.lessons);
  late int? _score = widget.detail.review?.reasoningScore;
  String? _predictionOutcome;

  bool get _askOutcome => widget.detail.prediction?.outcome == null &&
      widget.detail.prediction != null;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await ref.read(journalRepoProvider).saveReview(
          widget.detail.entry.id,
          whatHappened: _what.text,
          reasoningScore: _score!,
          lessons: _lessons.text,
          predictionOutcome: _predictionOutcome,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Review')),
        body: Form(
          key: _form,
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text(widget.detail.entry.decision,
                style: Theme.of(context).textTheme.titleMedium),
            Text('Expected: ${widget.detail.entry.expectedOutcome}'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _what,
              minLines: 2,
              maxLines: 6,
              decoration: const InputDecoration(labelText: 'What happened'),
              validator: (v) => (v ?? '').trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              initialValue: _score,
              decoration: const InputDecoration(
                labelText: 'Reasoning soundness (1-5)',
                helperText: 'Given what was known at the time, not the outcome',
              ),
              items: [for (var i = 1; i <= 5; i++) DropdownMenuItem(value: i, child: Text('$i'))],
              onChanged: (v) => setState(() => _score = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lessons,
              minLines: 2,
              maxLines: 6,
              decoration: const InputDecoration(labelText: 'Lessons (optional)'),
            ),
            if (_askOutcome) ...[
              const SectionHeader('Linked prediction outcome'),
              DropdownButtonFormField<String>(
                initialValue: _predictionOutcome,
                decoration: const InputDecoration(labelText: 'Outcome'),
                items: [
                  for (final o in const ['true', 'false', 'void'])
                    DropdownMenuItem(value: o, child: Text(outcomeLabel(o))),
                ],
                onChanged: (v) => setState(() => _predictionOutcome = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('Save review')),
          ]),
        ),
      );
}
