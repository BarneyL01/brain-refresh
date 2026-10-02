import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import 'look_back_screen.dart';
import 'rating_buttons.dart';

/// Asks for the overall rating from memory. Deliberately shows nothing
/// recorded during the experience, so the answer reflects memory alone.
class RememberedRatingScreen extends ConsumerStatefulWidget {
  const RememberedRatingScreen({super.key, required this.id});
  final int id;
  @override
  ConsumerState<RememberedRatingScreen> createState() =>
      _RememberedRatingScreenState();
}

class _RememberedRatingScreenState
    extends ConsumerState<RememberedRatingScreen> {
  int? _rating;

  Future<void> _save() async {
    await ref.read(experienceRepoProvider).saveRemembered(widget.id, _rating!);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LookBackScreen(id: widget.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(experienceProvider(widget.id)).value?.name ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Looking back')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Looking back, how would you rate $name overall? (1–5)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Answer from memory. Your check-ins are shown after you save.',
          ),
          const SizedBox(height: 24),
          RatingButtons(
            value: _rating,
            onChanged: (v) => setState(() => _rating = v),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            onPressed: _rating == null ? null : _save,
            child: const Text('Save rating'),
          ),
        ],
      ),
    );
  }
}
