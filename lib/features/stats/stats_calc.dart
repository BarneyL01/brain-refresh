import '../../data/database.dart';

enum StatsPeriod { days30, days90, all }

/// A resolved (True or False) prediction. Void and open ones never get here.
class Resolved {
  Resolved(this.confidence, this.outcome, this.resolvedAt, this.tagId);
  final int confidence;
  final bool outcome;
  final DateTime resolvedAt;
  final int? tagId;
}

class Band {
  Band(this.label, this.count, this.avgConfidence, this.pctTrue);
  final String label;
  final int count;

  /// Average stated confidence in percent, null if the band is empty.
  final double? avgConfidence;

  /// Percent of predictions in the band that came true, null if empty.
  final double? pctTrue;

  bool get greyedOut => count < 5;
}

/// Mean squared error between confidence (as decimal) and outcome (1/0).
double? brierScore(Iterable<Resolved> items) {
  if (items.isEmpty) return null;
  var sum = 0.0;
  for (final r in items) {
    final p = r.confidence / 100;
    final o = r.outcome ? 1.0 : 0.0;
    sum += (p - o) * (p - o);
  }
  return sum / items.length;
}

/// Brier score per calendar month, keyed by the first day of the month.
Map<DateTime, double> brierByMonth(Iterable<Resolved> items) {
  final groups = <DateTime, List<Resolved>>{};
  for (final r in items) {
    groups.putIfAbsent(DateTime(r.resolvedAt.year, r.resolvedAt.month), () => []).add(r);
  }
  final keys = groups.keys.toList()..sort();
  return {for (final k in keys) k: brierScore(groups[k]!)!};
}

/// Bands 50-59, 60-69, 70-79, 80-89, 90-99.
List<Band> calibrationBands(Iterable<Resolved> items) {
  return [
    for (var lo = 50; lo <= 90; lo += 10)
      () {
        final inBand =
            items.where((r) => r.confidence >= lo && r.confidence <= lo + 9).toList();
        if (inBand.isEmpty) return Band('$lo-${lo + 9}%', 0, null, null);
        final avg = inBand.map((r) => r.confidence).reduce((a, b) => a + b) / inBand.length;
        final pct = inBand.where((r) => r.outcome).length / inBand.length * 100;
        return Band('$lo-${lo + 9}%', inBand.length, avg, pct);
      }(),
  ];
}

/// Filters by tag and period (by resolved date) and drops void/open rows.
List<Resolved> resolvedOf(
  Iterable<Prediction> predictions, {
  int? tagId,
  StatsPeriod period = StatsPeriod.all,
  required DateTime now,
}) {
  final cutoff = switch (period) {
    StatsPeriod.days30 => now.subtract(const Duration(days: 30)),
    StatsPeriod.days90 => now.subtract(const Duration(days: 90)),
    StatsPeriod.all => null,
  };
  return [
    for (final p in predictions)
      if ((p.outcome == 'true' || p.outcome == 'false') &&
          p.resolvedAt != null &&
          (tagId == null || p.tagId == tagId) &&
          (cutoff == null || !p.resolvedAt!.isBefore(cutoff)))
        Resolved(p.confidence, p.outcome == 'true', p.resolvedAt!, p.tagId),
  ];
}

class PredictionCounts {
  PredictionCounts(this.open, this.due, this.resolvedTrue, this.resolvedFalse, this.voided);
  final int open, due, resolvedTrue, resolvedFalse, voided;
}

PredictionCounts predictionCounts(
  Iterable<Prediction> predictions, {
  int? tagId,
  required String today,
}) {
  var open = 0, due = 0, t = 0, f = 0, v = 0;
  for (final p in predictions.where((p) => tagId == null || p.tagId == tagId)) {
    switch (p.outcome) {
      case null:
        open++;
        if (p.resolveBy.compareTo(today) <= 0) due++;
      case 'true':
        t++;
      case 'false':
        f++;
      default:
        v++;
    }
  }
  return PredictionCounts(open, due, t, f, v);
}

class JournalStats {
  JournalStats(this.created, this.reviewed, this.overdue, this.avgScore, this.scoreVsOutcome);
  final int created, reviewed, overdue;
  final double? avgScore;

  /// score (1-5) -> {'happened': n, 'didNot': n, 'unknown': n}
  final Map<int, Map<String, int>> scoreVsOutcome;
}

JournalStats journalStats({
  required Iterable<JournalEntry> entries,
  required Iterable<JournalReview> reviews,
  required Iterable<Prediction> predictions,
  int? tagId,
  StatsPeriod period = StatsPeriod.all,
  required DateTime now,
  required String today,
}) {
  final cutoff = switch (period) {
    StatsPeriod.days30 => now.subtract(const Duration(days: 30)),
    StatsPeriod.days90 => now.subtract(const Duration(days: 90)),
    StatsPeriod.all => null,
  };
  final es = entries
      .where((e) =>
          (tagId == null || e.tagId == tagId) &&
          (cutoff == null || !e.createdAt.isBefore(cutoff)))
      .toList();
  final ids = es.map((e) => e.id).toSet();
  final rs = reviews.where((r) => ids.contains(r.entryId)).toList();
  final reviewedIds = rs.map((r) => r.entryId).toSet();
  final overdue =
      es.where((e) => !reviewedIds.contains(e.id) && e.reviewDate.compareTo(today) < 0).length;
  final byEntry = {
    for (final p in predictions)
      if (p.journalEntryId != null) p.journalEntryId!: p,
  };
  final table = {for (var s = 1; s <= 5; s++) s: {'happened': 0, 'didNot': 0, 'unknown': 0}};
  for (final r in rs) {
    final o = byEntry[r.entryId]?.outcome;
    final key = o == 'true' ? 'happened' : o == 'false' ? 'didNot' : 'unknown';
    table[r.reasoningScore]![key] = table[r.reasoningScore]![key]! + 1;
  }
  final avg = rs.isEmpty
      ? null
      : rs.map((r) => r.reasoningScore).reduce((a, b) => a + b) / rs.length;
  return JournalStats(es.length, rs.length, overdue, avg, table);
}
