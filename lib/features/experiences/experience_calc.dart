import 'package:intl/intl.dart';

import '../../data/database.dart';

const ratingLabels = {
  1: 'Very bad',
  2: 'Bad',
  3: 'Okay',
  4: 'Good',
  5: 'Very good',
};

const checkInNoteMax = 200;
const defaultRememberAfterDays = 7;
const rememberAfterChoices = [0, 1, 3, 7, 14, 30];

const frequencies = {
  'daily': 'Daily',
  'session': 'Each session',
  'manual': 'Manual',
};
const markers = {'none': 'None', 'high': 'High point', 'low': 'Low point'};
const repeatDecisions = {
  'yes': 'Yes',
  'no': 'No',
  'yes_with_changes': 'Yes, with changes',
};

/// Check-ins in time order (ties broken by id).
List<CheckIn> sortedCheckIns(Iterable<CheckIn> items) =>
    items.toList()..sort((a, b) {
      final c = a.checkedAt.compareTo(b.checkedAt);
      return c != 0 ? c : a.id.compareTo(b.id);
    });

class ExperienceSummary {
  ExperienceSummary({
    required this.total,
    required this.average,
    required this.positiveCount,
    required this.lowest,
    required this.highest,
    required this.ending,
  });
  final int total;
  final double average;

  /// Check-ins rated 4 or 5.
  final int positiveCount;
  final int lowest;
  final int highest;

  /// Rating of the most recent check-in.
  final int ending;

  double get positiveShare => positiveCount / total;
}

ExperienceSummary? summarize(Iterable<CheckIn> items) {
  final list = sortedCheckIns(items);
  if (list.isEmpty) return null;
  final ratings = list.map((c) => c.rating);
  return ExperienceSummary(
    total: list.length,
    average: ratings.reduce((a, b) => a + b) / list.length,
    positiveCount: ratings.where((r) => r >= 4).length,
    lowest: ratings.reduce((a, b) => a < b ? a : b),
    highest: ratings.reduce((a, b) => a > b ? a : b),
    ending: list.last.rating,
  );
}

/// Mean rating per participant; the key null is the main user.
Map<int?, double> averageByParticipant(Iterable<CheckIn> items) {
  final groups = <int?, List<int>>{};
  for (final c in items) {
    groups.putIfAbsent(c.participantId, () => []).add(c.rating);
  }
  return {
    for (final e in groups.entries)
      e.key: e.value.reduce((a, b) => a + b) / e.value.length,
  };
}

/// remembered rating minus average, or null if either is missing.
double? gapOf(int? remembered, double? average) =>
    remembered == null || average == null ? null : remembered - average;

/// The gap message shows only when the two differ by 1 point or more.
bool showGap(double? gap) => gap != null && gap.abs() >= 1.0 - 1e-9;

String ratingText(num r) => '${_oneDecimal(r)}/5';

String _oneDecimal(num v) =>
    v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1);

/// Plain statement of the remembered rating next to what was recorded.
String gapMessage(int remembered, ExperienceSummary s) {
  final b = StringBuffer(
    'You now rate this $remembered/5. While it was happening, your average was '
    '${s.average.toStringAsFixed(1)}/5, and ${s.positiveCount} of ${s.total} '
    'check-ins were rated Good or Very good.',
  );
  if (s.total > 1 && s.ending == s.lowest) {
    b.write(' Your lowest rating was on the last check-in.');
  }
  return b.toString();
}

/// When the remembered-rating question becomes available.
DateTime? rememberedUnlockAt(Experience e) =>
    e.status == 'finished' && e.finishedAt != null
    ? e.finishedAt!.add(Duration(days: e.rememberAfterDays))
    : null;

/// Finished, not yet answered, and the wait is over.
bool isRememberedDue(Experience e, DateTime now) {
  final unlock = rememberedUnlockAt(e);
  return e.rememberedRating == null && unlock != null && !now.isBefore(unlock);
}

/// Check-in runs for the timeline. For daily experiences a missed day breaks
/// the run, so the gap is shown rather than filled in.
List<List<CheckIn>> splitRuns(
  List<CheckIn> sorted, {
  required bool breakOnMissedDay,
}) {
  if (sorted.isEmpty) return [];
  final runs = <List<CheckIn>>[
    [sorted.first],
  ];
  for (var i = 1; i < sorted.length; i++) {
    final a = sorted[i - 1].checkedAt;
    final b = sorted[i].checkedAt;
    final days = DateTime(
      b.year,
      b.month,
      b.day,
    ).difference(DateTime(a.year, a.month, a.day)).inDays;
    if (breakOnMissedDay && days > 1) {
      runs.add([sorted[i]]);
    } else {
      runs.last.add(sorted[i]);
    }
  }
  return runs;
}

String _normalizeName(String s) => s
    .toLowerCase()
    .replaceAll(RegExp(r'[0-9]'), ' ')
    .replaceAll(RegExp(r'[^a-z\s]'), ' ')
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .join(' ');

/// "Camping trip 2027" is similar to "Family camping trip 2026".
bool similarNames(String a, String b) {
  final x = _normalizeName(a), y = _normalizeName(b);
  if (x.length < 4 || y.length < 4) return false;
  return x == y || x.contains(y) || y.contains(x);
}

String _cell(String? s) => (s ?? '')
    .replaceAll('|', r'\|')
    .replaceAll(RegExp(r'\s*\n\s*'), ' ')
    .trim();

/// The full record as Markdown, for pasting into a journal or another app.
String lookBackMarkdown({
  required Experience experience,
  required List<ExperienceParticipant> participants,
  required List<CheckIn> checkIns,
  required DateTime now,
  String? decision,
  String? decisionNotes,
}) {
  final e = experience;
  // Allow passing a decision typed but not yet saved.
  final repeat = decision ?? e.repeatDecision;
  final repeatNotes = decision != null ? decisionNotes : e.repeatNotes;
  final list = sortedCheckIns(checkIns);
  final summary = summarize(list);
  final names = {for (final p in participants) p.id: p.displayName};
  String who(int? id) => id == null ? 'Me' : (names[id] ?? 'Unknown');
  final when = DateFormat('yyyy-MM-dd HH:mm');
  final day = DateFormat('yyyy-MM-dd');

  final b = StringBuffer()
    ..writeln('# ${e.name.replaceAll('\n', ' ')}')
    ..writeln()
    ..writeln('- Started: ${e.startDate}')
    ..writeln(
      '- ${e.status == 'finished' ? 'Ended' : 'Expected end'}: ${e.endDate ?? 'not set'}',
    )
    ..writeln(
      '- Check-in frequency: ${frequencies[e.checkinFrequency] ?? e.checkinFrequency}',
    )
    ..writeln('- Status: ${e.status == 'finished' ? 'Finished' : 'Active'}')
    ..writeln()
    ..writeln('## Summary')
    ..writeln();

  if (summary == null) {
    b.writeln('No check-ins recorded.');
  } else {
    b
      ..writeln('| Measure | Value |')
      ..writeln('|---|---|')
      ..writeln('| Check-ins | ${summary.total} |')
      ..writeln(
        '| Average while it was happening | ${summary.average.toStringAsFixed(1)} / 5 |',
      )
      ..writeln(
        '| Rated Good or Very good | ${summary.positiveCount} of ${summary.total} '
        '(${(summary.positiveShare * 100).round()}%) |',
      )
      ..writeln('| Lowest | ${summary.lowest} / 5 |')
      ..writeln('| Highest | ${summary.highest} / 5 |')
      ..writeln('| Final check-in | ${summary.ending} / 5 |');
    if (e.rememberedRating != null) {
      b.writeln('| Remembered rating | ${e.rememberedRating} / 5 |');
    }
    final gap = gapOf(e.rememberedRating, summary.average);
    if (showGap(gap)) {
      b
        ..writeln()
        ..writeln(gapMessage(e.rememberedRating!, summary));
    }

    if (participants.isNotEmpty) {
      final avgs = averageByParticipant(list);
      final counts = <int?, int>{};
      for (final c in list) {
        counts[c.participantId] = (counts[c.participantId] ?? 0) + 1;
      }
      b
        ..writeln()
        ..writeln('## By person')
        ..writeln()
        ..writeln('| Person | Check-ins | Average |')
        ..writeln('|---|---|---|');
      for (final id in avgs.keys) {
        b.writeln(
          '| ${_cell(who(id))} | ${counts[id]} | ${avgs[id]!.toStringAsFixed(1)} / 5 |',
        );
      }
    }

    b
      ..writeln()
      ..writeln('## Check-ins')
      ..writeln()
      ..writeln('| When | Who | Rating | Marker | Note |')
      ..writeln('|---|---|---|---|---|');
    for (final c in list) {
      b.writeln(
        '| ${when.format(c.checkedAt)} | ${_cell(who(c.participantId))} | '
        '${c.rating} ${ratingLabels[c.rating]} | '
        '${c.marker == 'none' ? '' : markers[c.marker]} | ${_cell(c.note)} |',
      );
    }
  }

  if (repeat != null) {
    b
      ..writeln()
      ..writeln('## Would I do this again?')
      ..writeln()
      ..writeln('**${repeatDecisions[repeat] ?? repeat}**');
    final notes = repeatNotes?.trim();
    if (notes != null && notes.isNotEmpty) {
      b
        ..writeln()
        ..writeln('What I would change: $notes');
    }
  }

  b
    ..writeln()
    ..writeln('_Exported from Brain Refresh on ${day.format(now)}._');
  return b.toString();
}
