import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/dates.dart';
import '../../core/widgets.dart';
import '../../data/database.dart';
import '../../data/providers.dart';
import 'experience_calc.dart';

/// The full record: timeline, summary numbers, gap message, notes and the
/// repeat decision. Everything can be copied out as Markdown.
class LookBackScreen extends ConsumerStatefulWidget {
  const LookBackScreen({super.key, required this.id});
  final int id;
  @override
  ConsumerState<LookBackScreen> createState() => _LookBackScreenState();
}

class _LookBackScreenState extends ConsumerState<LookBackScreen> {
  final _changes = TextEditingController();
  String? _decision;
  bool _seeded = false;

  /// Uses the decision as currently typed, even if not saved yet.
  String _markdown(
    Experience e,
    List<ExperienceParticipant> people,
    List<CheckIn> list,
  ) => lookBackMarkdown(
    experience: e,
    participants: people,
    checkIns: list,
    now: DateTime.now(),
    decision: _decision,
    decisionNotes: _changes.text,
  );

  Future<void> _copy(String md) async {
    await Clipboard.setData(ClipboardData(text: md));
    if (mounted) showMessage(context, 'Copied as Markdown');
  }

  Future<void> _saveDecision() async {
    await ref
        .read(experienceRepoProvider)
        .saveDecision(widget.id, _decision!, _changes.text);
    if (mounted) showMessage(context, 'Saved');
  }

  @override
  Widget build(BuildContext context) {
    final e = ref.watch(experienceProvider(widget.id)).value;
    final list =
        ref.watch(checkInsProvider(widget.id)).value ?? const <CheckIn>[];
    final people = ref.watch(participantsProvider(widget.id)).value ?? const [];
    if (e == null) return Scaffold(appBar: AppBar());

    if (!_seeded) {
      _seeded = true;
      _decision = e.repeatDecision;
      _changes.text = e.repeatNotes ?? '';
    }

    final summary = summarize(list);
    final remembered = e.rememberedRating;
    final gap = gapOf(remembered, summary?.average);
    final finished = e.status == 'finished';
    final names = {for (final p in people) p.id: p.displayName};
    final md = _markdown(e, people, list);
    final fmt = DateFormat('EEE d MMM, HH:mm');
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(e.name),
        actions: [
          IconButton(
            tooltip: 'Copy as Markdown',
            icon: const Icon(Icons.copy),
            onPressed: () => _copy(md),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            finished
                ? 'Here is what you recorded while it was happening.'
                : 'Progress so far. Here is what you have recorded.',
            style: theme.textTheme.titleMedium,
          ),
          const SectionHeader('Timeline'),
          if (summary == null)
            const EmptyLine('No check-ins recorded')
          else
            _Timeline(experience: e, checkIns: list, people: people),
          const SectionHeader('Summary'),
          if (summary != null)
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.4),
              },
              children: [
                _row(
                  'Average of all check-ins',
                  ratingText(double.parse(summary.average.toStringAsFixed(1))),
                ),
                _row(
                  'Rated Good or Very good',
                  '${summary.positiveCount} of ${summary.total} (${(summary.positiveShare * 100).round()}%)',
                ),
                _row('Lowest check-in', '${summary.lowest}/5'),
                _row('Highest check-in', '${summary.highest}/5'),
                _row('Final check-in', '${summary.ending}/5'),
                if (remembered != null)
                  _row('Remembered rating', '$remembered/5'),
              ],
            ),
          if (people.isNotEmpty && summary != null) ...[
            const SizedBox(height: 12),
            Text('Average by person', style: theme.textTheme.labelLarge),
            for (final a in averageByParticipant(list).entries)
              Text(
                '${a.key == null ? 'Me' : names[a.key] ?? 'Unknown'}: '
                '${a.value.toStringAsFixed(1)}/5',
              ),
          ],
          if (showGap(gap) && summary != null) ...[
            const SizedBox(height: 16),
            Card(
              color: theme.colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(gapMessage(remembered!, summary)),
              ),
            ),
          ],
          const SectionHeader('Notes'),
          if (!list.any((c) => c.note != null)) const EmptyLine('No notes'),
          for (final c in list.where((c) => c.note != null))
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(c.note!),
              subtitle: Text(
                '${fmt.format(c.checkedAt)} · ${c.rating} ${ratingLabels[c.rating]}'
                '${c.participantId != null ? ' · ${names[c.participantId] ?? ''}' : ''}'
                '${c.marker != 'none' ? ' · ${markers[c.marker]}' : ''}',
              ),
            ),
          if (finished && remembered != null) ...[
            const SectionHeader('Would you do this again?'),
            SegmentedButton<String>(
              segments: [
                for (final d in repeatDecisions.entries)
                  ButtonSegment(value: d.key, label: Text(d.value)),
              ],
              selected: {?_decision},
              emptySelectionAllowed: true,
              onSelectionChanged: (s) =>
                  setState(() => _decision = s.isEmpty ? null : s.first),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _changes,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'What would you change?',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _decision == null ? null : _saveDecision,
              child: const Text('Save'),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            icon: const Icon(Icons.copy),
            label: const Text('Copy as Markdown'),
            onPressed: () => _copy(md),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Copies the full record so you can paste it into a journal or '
              'another app.',
            ),
          ),
        ],
      ),
    );
  }

  TableRow _row(String label, String value) => TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(label),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.experience,
    required this.checkIns,
    required this.people,
  });
  final Experience experience;
  final List<CheckIn> checkIns;
  final List<ExperienceParticipant> people;

  static const _palette = [
    Color(0xFF3F51B5),
    Color(0xFFE67E22),
    Color(0xFF16A085),
    Color(0xFF8E44AD),
    Color(0xFF7F8C8D),
  ];

  @override
  Widget build(BuildContext context) {
    final sorted = sortedCheckIns(checkIns);
    final first = sorted.first.checkedAt;
    final start = parseYmd(experience.startDate);
    final base = DateTime(
      (first.isBefore(start) ? first : start).year,
      (first.isBefore(start) ? first : start).month,
      (first.isBefore(start) ? first : start).day,
    );
    double xOf(DateTime t) => t.difference(base).inMinutes / 1440;
    final maxX = xOf(sorted.last.checkedAt)
        .ceilToDouble()
        .clamp(1.0, double.infinity);
    final span = maxX;
    final interval = (span / 4).ceilToDouble().clamp(1.0, double.infinity);

    // One series per person; the main user is the first colour.
    final ids = <int?>[null, ...people.map((p) => p.id)];
    final series = <({String name, Color color, List<CheckIn> items})>[];
    for (var i = 0; i < ids.length; i++) {
      final items = sorted.where((c) => c.participantId == ids[i]).toList();
      if (items.isEmpty) continue;
      series.add((
        name: ids[i] == null
            ? 'Me'
            : people.firstWhere((p) => p.id == ids[i]).displayName,
        color: _palette[i % _palette.length],
        items: items,
      ));
    }

    final bars = <LineChartBarData>[];
    for (final s in series) {
      for (final run in splitRuns(
        s.items,
        breakOnMissedDay: experience.checkinFrequency == 'daily',
      )) {
        bars.add(
          LineChartBarData(
            spots: [
              for (final c in run)
                FlSpot(xOf(c.checkedAt), c.rating.toDouble()),
            ],
            color: s.color,
            barWidth: 2,
            isCurved: false,
            dotData: FlDotData(
              getDotPainter: (spot, percent, bar, index) {
                final c = run[index];
                if (c.marker == 'none') {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: s.color,
                    strokeWidth: 0,
                  );
                }
                return FlDotCirclePainter(
                  radius: 7,
                  color: s.color,
                  strokeWidth: 3,
                  strokeColor: c.marker == 'high'
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828),
                );
              },
            ),
          ),
        );
      }
    }

    final dateFmt = DateFormat('d MMM');
    final hasMarkers = sorted.any((c) => c.marker != 'none');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.4,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: maxX,
              minY: 0,
              maxY: 6,
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 28,
                    getTitlesWidget: (v, meta) =>
                        v >= 1 && v <= 5 && v == v.roundToDouble()
                        ? SideTitleWidget(
                            meta: meta,
                            child: Text('${v.round()}'),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval,
                    reservedSize: 28,
                    getTitlesWidget: (v, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(
                        dateFmt.format(base.add(Duration(days: v.round()))),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
              lineBarsData: bars,
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (series.length > 1)
          Wrap(
            spacing: 12,
            children: [
              for (final s in series)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 10, color: s.color),
                    const SizedBox(width: 4),
                    Text(s.name),
                  ],
                ),
            ],
          ),
        Text(
          'Rating 1 (very bad) to 5 (very good). '
          '${experience.checkinFrequency == 'daily' ? 'Missed days are left blank. ' : ''}'
          '${hasMarkers ? 'Green ring: high point. Red ring: low point.' : ''}',
        ),
      ],
    );
  }
}
