import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/journal_repository.dart';
import '../../data/prediction_repository.dart';
import '../../data/providers.dart';
import '../journal/journal_detail_screen.dart';
import '../predictions/prediction_detail_screen.dart';
import 'day_plan_screen.dart';
import 'shutdown_screen.dart';
import 'winddown_run_screen.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});
  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  late bool _evening = isEvening(ref.read(prefsProvider));

  void _setEvening(bool v) {
    setState(() => _evening = v);
    setEvening(ref.read(prefsProvider), v);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Today')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Morning'), icon: Icon(Icons.wb_sunny)),
              ButtonSegment(value: true, label: Text('Evening'), icon: Icon(Icons.nightlight)),
            ],
            selected: {_evening},
            onSelectionChanged: (s) => _setEvening(s.first),
          ),
          if (_evening) const _Evening() else const _Morning(),
        ]),
      );
}

class _Morning extends ConsumerWidget {
  const _Morning();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = todayYmd();
    final duePreds = ref.watch(predictionsByFilter(PredictionFilter.due)).value ?? const [];
    final dueJournal = ref.watch(journalByFilter(JournalFilter.due)).value ?? const [];
    final plan = ref.watch(dayPlanProvider(today)).value;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHeader('Predictions due to resolve'),
      if (duePreds.isEmpty) const EmptyLine('Nothing due'),
      for (final p in duePreds)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(p.statement),
          subtitle: Text('${p.confidence}% · ${p.resolveBy}'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => PredictionDetailScreen(id: p.id))),
        ),
      const SectionHeader('Journal reviews due'),
      if (dueJournal.isEmpty) const EmptyLine('Nothing due'),
      for (final e in dueJournal)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(e.decision),
          subtitle: Text('Review date ${e.reviewDate}'),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => JournalDetailScreen(id: e.id))),
        ),
      const SectionHeader("Tomorrow's first step (from yesterday's shutdown)"),
      FutureBuilder(
        future: ref.read(shutdownRepoProvider).latestBefore(today),
        builder: (c, s) {
          final sd = s.data;
          if (sd == null) return const EmptyLine('Not set');
          return Text('${sd.firstStep}${sd.date == ymd(DateTime.now().subtract(const Duration(days: 1))) ? '' : ' (${sd.date})'}');
        },
      ),
      SectionHeader(
        "Today's plan",
        trailing: TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => DayPlanScreen(date: today))),
          child: Text(plan == null ? 'Create' : 'Edit'),
        ),
      ),
      if (plan == null) const EmptyLine('No plan for today'),
      if (plan != null) ...[
        if (plan.tasks.isEmpty) const EmptyLine('No tasks'),
        for (final t in plan.tasks)
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(t.body,
                style: t.done ? const TextStyle(decoration: TextDecoration.lineThrough) : null),
            value: t.done,
            onChanged: (v) => ref.read(dayPlanRepoProvider).setDone(t.id, v ?? false),
          ),
        if (plan.defaults.isNotEmpty) const SectionHeader('Evening defaults'),
        for (final d in plan.defaults) Text('${d.label}: ${d.choice}'),
      ],
    ]);
  }
}

class _Evening extends ConsumerWidget {
  const _Evening();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tomorrow = tomorrowYmd();
    final today = todayYmd();
    final plan = ref.watch(dayPlanProvider(tomorrow)).value;
    final shutdown = ref.watch(shutdownProvider(today)).value;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHeader('Decide early'),
      Card(
        child: ListTile(
          title: Text(plan == null ? "Plan tomorrow" : "Edit tomorrow's plan"),
          subtitle: Text(plan == null
              ? 'Top 3 tasks and tonight\'s defaults'
              : '${plan.tasks.length} tasks · ${plan.defaults.length} defaults'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => DayPlanScreen(date: tomorrow))),
        ),
      ),
      const SectionHeader('Shutdown'),
      Card(
        child: ListTile(
          title: Text(shutdown?.closedAt != null ? 'Work closed' : 'Shutdown for today'),
          subtitle: shutdown?.firstStep.isNotEmpty == true
              ? Text('First step: ${shutdown!.firstStep}')
              : const Text('Open loops, first step, close work'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => ShutdownScreen(date: today))),
        ),
      ),
      const SectionHeader('Wind-down'),
      Card(
        child: ListTile(
          title: const Text('Start wind-down'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const WinddownRunScreen())),
        ),
      ),
    ]);
  }
}
