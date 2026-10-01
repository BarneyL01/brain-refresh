import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database.dart';
import '../../data/providers.dart';

/// Shows one wind-down step at a time: name, timer if set, and Next.
class WinddownRunScreen extends ConsumerStatefulWidget {
  const WinddownRunScreen({super.key});
  @override
  ConsumerState<WinddownRunScreen> createState() => _WinddownRunScreenState();
}

class _WinddownRunScreenState extends ConsumerState<WinddownRunScreen> {
  final _startedAt = DateTime.now();
  final _completed = <String>[];
  List<WinddownStep>? _steps;
  int _index = 0;
  Timer? _timer;
  int _remaining = 0;
  bool _logged = false;

  @override
  void initState() {
    super.initState();
    ref.read(winddownRepoProvider).steps().then((s) {
      if (!mounted) return;
      setState(() => _steps = s);
      _startStep();
    });
  }

  void _startStep() {
    _timer?.cancel();
    final steps = _steps!;
    if (_index >= steps.length) return;
    final m = steps[_index].minutes;
    _remaining = m == null ? 0 : m * 60;
    if (m != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_remaining > 0) setState(() => _remaining--);
      });
    }
  }

  void _next() {
    _completed.add(_steps![_index].name);
    setState(() => _index++);
    _startStep();
    if (_index >= _steps!.length) _log();
  }

  void _log() {
    if (_logged) return;
    _logged = true;
    ref.read(winddownRepoProvider).logRun(_startedAt, _completed);
  }

  @override
  void dispose() {
    _timer?.cancel();
    // Leaving early logs what was completed so far.
    if (_steps != null && !_logged && _completed.isNotEmpty) _log();
    super.dispose();
  }

  String _fmt(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final steps = _steps;
    if (steps == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('No wind-down steps. Add some in Settings.')),
      );
    }
    if (_index >= steps.length) {
      return Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Wind-down complete', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
          ]),
        ),
      );
    }
    final step = steps[_index];
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(step.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium),
            if (step.minutes != null) ...[
              const SizedBox(height: 24),
              Text(_fmt(_remaining), style: Theme.of(context).textTheme.displayMedium),
              TextButton(
                onPressed: () => setState(() => _remaining += 300),
                child: const Text('+5 min'),
              ),
            ],
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _next,
              child: Text(step.minutes != null && _remaining > 0 ? 'Finish early' : 'Next'),
            ),
          ]),
        ),
      ),
    );
  }
}
