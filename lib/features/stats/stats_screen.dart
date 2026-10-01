import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/providers.dart';
import 'stats_calc.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});
  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  StatsPeriod _period = StatsPeriod.all;
  int? _tagId;

  @override
  Widget build(BuildContext context) {
    final preds = ref.watch(allPredictionsProvider).value ?? const [];
    final entries = ref.watch(allJournalProvider).value ?? const [];
    final reviews = ref.watch(allReviewsProvider).value ?? const [];
    final tags = ref.watch(tagsProvider).value ?? const [];
    final now = DateTime.now();
    final today = todayYmd(now);

    final resolved = resolvedOf(preds, tagId: _tagId, period: _period, now: now);
    final brier = brierScore(resolved);
    final bands = calibrationBands(resolved);
    final counts = predictionCounts(preds, tagId: _tagId, today: today);
    final js = journalStats(
      entries: entries,
      reviews: reviews,
      predictions: preds,
      tagId: _tagId,
      period: _period,
      now: now,
      today: today,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SegmentedButton<StatsPeriod>(
          segments: const [
            ButtonSegment(value: StatsPeriod.days30, label: Text('30 days')),
            ButtonSegment(value: StatsPeriod.days90, label: Text('90 days')),
            ButtonSegment(value: StatsPeriod.all, label: Text('All time')),
          ],
          selected: {_period},
          onSelectionChanged: (s) => setState(() => _period = s.first),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<int?>(
          initialValue: tags.any((t) => t.id == _tagId) ? _tagId : null,
          decoration: const InputDecoration(labelText: 'Tag'),
          items: [
            const DropdownMenuItem(value: null, child: Text('All tags')),
            for (final t in tags) DropdownMenuItem(value: t.id, child: Text(t.name)),
          ],
          onChanged: (v) => setState(() => _tagId = v),
        ),
        const SectionHeader('Brier score'),
        Text(
          brier == null ? 'No resolved predictions' : brier.toStringAsFixed(3),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text('0 is perfect. Always answering 50% scores 0.25.'),
        const SizedBox(height: 12),
        _BrierTrend(data: brierByMonth(resolved)),
        const SectionHeader('Calibration'),
        _CalibrationChart(bands: bands),
        const SizedBox(height: 8),
        Table(
          columnWidths: const {0: FlexColumnWidth(1.2)},
          children: [
            const TableRow(children: [
              Text('Band', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Count', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Avg conf.', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('True', style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            for (final b in bands)
              TableRow(
                children: [
                  Text(b.label),
                  Text('${b.count}'),
                  Text(b.avgConfidence == null ? '-' : '${b.avgConfidence!.round()}%'),
                  Text(b.pctTrue == null ? '-' : '${b.pctTrue!.round()}%'),
                ]
                    .map((w) => Opacity(opacity: b.greyedOut ? 0.4 : 1, child: w))
                    .toList(),
              ),
          ],
        ),
        const Text('Bands with fewer than 5 predictions are greyed out.'),
        const SectionHeader('Predictions'),
        Text('Open ${counts.open} · Due ${counts.due} · '
            'True ${counts.resolvedTrue} · False ${counts.resolvedFalse} · Void ${counts.voided}'),
        const SectionHeader('Journal'),
        Text('Entries created ${js.created} · Reviews completed ${js.reviewed} · '
            'Overdue ${js.overdue}'),
        Text(js.avgScore == null
            ? 'Average reasoning score: -'
            : 'Average reasoning score: ${js.avgScore!.toStringAsFixed(1)} / 5'),
        const SizedBox(height: 8),
        Table(children: [
          const TableRow(children: [
            Text('Score', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Happened', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Did not', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Unknown', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          for (var s = 1; s <= 5; s++)
            TableRow(children: [
              Text('$s'),
              Text('${js.scoreVsOutcome[s]!['happened']}'),
              Text('${js.scoreVsOutcome[s]!['didNot']}'),
              Text('${js.scoreVsOutcome[s]!['unknown']}'),
            ]),
        ]),
        const Text('Outcome comes from the linked prediction; Unknown means none or unresolved.'),
      ]),
    );
  }
}

class _CalibrationChart extends StatelessWidget {
  const _CalibrationChart({required this.bands});
  final List<Band> bands;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    List<FlSpot> spots(bool strong) => [
          for (final b in bands)
            if (b.count > 0 && b.greyedOut != strong) FlSpot(b.avgConfidence!, b.pctTrue!),
        ];
    LineChartBarData dots(List<FlSpot> s, Color c) => LineChartBarData(
          spots: s,
          color: c,
          barWidth: 0,
          dotData: FlDotData(
            getDotPainter: (spot, p, bar, i) =>
                FlDotCirclePainter(radius: 5, color: c, strokeWidth: 0),
          ),
        );
    return AspectRatio(
      aspectRatio: 1.3,
      child: LineChart(LineChartData(
        minX: 50,
        maxX: 100,
        minY: 0,
        maxY: 100,
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            axisNameWidget: const Text('Came true (%)'),
            sideTitles: const SideTitles(showTitles: true, interval: 25, reservedSize: 32),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: const Text('Stated confidence (%)'),
            sideTitles: const SideTitles(showTitles: true, interval: 10, reservedSize: 28),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(50, 50), FlSpot(100, 100)],
            color: scheme.outline,
            barWidth: 1,
            dashArray: [4, 4],
            dotData: const FlDotData(show: false),
          ),
          dots(spots(false), scheme.outline),
          dots(spots(true), scheme.primary),
        ],
      )),
    );
  }
}

class _BrierTrend extends StatelessWidget {
  const _BrierTrend({required this.data});
  final Map<DateTime, double> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const EmptyLine('No monthly data yet');
    final months = data.keys.toList();
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
        minY: 0,
        maxY: 1,
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 0.25, reservedSize: 36)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (v, meta) {
                final i = v.round();
                if (i != v || i < 0 || i >= months.length) return const SizedBox.shrink();
                return Text(DateFormat('MMM yy').format(months[i]),
                    style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [for (var i = 0; i < months.length; i++) FlSpot(i.toDouble(), data[months[i]]!)],
            color: Theme.of(context).colorScheme.primary,
            barWidth: 2,
          ),
        ],
      )),
    );
  }
}
