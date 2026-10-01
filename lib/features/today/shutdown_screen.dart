import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import 'winddown_run_screen.dart';

class ShutdownScreen extends ConsumerStatefulWidget {
  const ShutdownScreen({super.key, required this.date});
  final String date;
  @override
  ConsumerState<ShutdownScreen> createState() => _ShutdownScreenState();
}

class _ShutdownScreenState extends ConsumerState<ShutdownScreen> {
  final _firstStep = TextEditingController();
  final _newLoop = TextEditingController();
  List<DayPlanTask> _suggestions = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final repo = ref.read(shutdownRepoProvider);
    final existing = await repo.watch(widget.date).first;
    _firstStep.text = existing?.firstStep ?? '';
    await _refreshSuggestions();
    setState(() => _loaded = true);
  }

  Future<void> _refreshSuggestions() async {
    final s = await ref.read(shutdownRepoProvider).suggestions(widget.date);
    if (mounted) setState(() => _suggestions = s);
  }

  Future<void> _addLoop() async {
    final text = _newLoop.text.trim();
    if (text.isEmpty) return;
    await ref.read(shutdownRepoProvider).addLoop(text);
    _newLoop.clear();
  }

  Future<void> _close() async {
    final repo = ref.read(shutdownRepoProvider);
    try {
      await repo.close(widget.date, _firstStep.text);
    } on ArgumentError {
      if (mounted) showMessage(context, "Tomorrow's first step is required");
      return;
    }
    if (!mounted) return;
    final start = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Work closed'),
        content: const Text('Start wind-down now?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Not now')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Start')),
        ],
      ),
    );
    if (!mounted) return;
    if (start == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const WinddownRunScreen()));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(shutdownRepoProvider);
    final loops = ref.watch(openLoopsProvider).value ?? const [];
    final closed = ref.watch(shutdownProvider(widget.date)).value?.closedAt;
    return Scaffold(
      appBar: AppBar(title: const Text('Shutdown')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(padding: const EdgeInsets.all(16), children: [
              const SectionHeader('1. Open loops'),
              if (loops.isEmpty) const EmptyLine('No open loops'),
              for (final l in loops)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: false,
                    onChanged: (_) async {
                      await repo.closeLoop(l.id);
                      _refreshSuggestions();
                    },
                  ),
                  title: Text(l.body),
                  subtitle: Text('Open ${daysBetween(l.openedOn, widget.date)} days'),
                  trailing: IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () async {
                      await repo.deleteLoop(l.id);
                      _refreshSuggestions();
                    },
                  ),
                ),
              if (_suggestions.isNotEmpty) const SectionHeader('Suggested from unticked tasks'),
              for (final s in _suggestions)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(s.body),
                  trailing: TextButton(
                    onPressed: () async {
                      await repo.addLoop(s.body, sourceTaskId: s.id);
                      _refreshSuggestions();
                    },
                    child: const Text('Add as loop'),
                  ),
                ),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _newLoop,
                    onSubmitted: (_) => _addLoop(),
                    decoration: const InputDecoration(labelText: 'New open loop'),
                  ),
                ),
                IconButton(tooltip: 'Add', icon: const Icon(Icons.add), onPressed: _addLoop),
              ]),
              const SectionHeader("2. Tomorrow's first step"),
              TextField(
                controller: _firstStep,
                decoration: const InputDecoration(labelText: 'One line (required to close)'),
              ),
              const SectionHeader('3. Close work'),
              if (closed != null) ...[
                Text('Closed at ${TimeOfDay.fromDateTime(closed).format(context)}'),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: [
                  FilledButton(
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const WinddownRunScreen())),
                    child: const Text('Start wind-down'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await repo.saveDraft(widget.date, _firstStep.text);
                      await repo.reopen(widget.date);
                    },
                    child: const Text('Reopen'),
                  ),
                ]),
              ] else
                FilledButton(onPressed: _close, child: const Text('Close work')),
            ]),
    );
  }
}
