import 'package:drift/drift.dart';

import '../core/dates.dart';
import '../core/rules.dart';
import 'database.dart';
import 'prediction_repository.dart';

enum JournalFilter { open, due, reviewed }

class JournalDetail {
  JournalDetail(this.entry, this.options, this.review, this.prediction);
  final JournalEntry entry;
  final List<JournalOption> options;
  final JournalReview? review;
  final Prediction? prediction;
}

class JournalRepository {
  JournalRepository(this.db, [DateTime Function()? clock])
      : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  Stream<List<JournalEntry>> watchAll() => db.select(db.journalEntries).watch();
  Stream<List<JournalReview>> watchReviews() => db.select(db.journalReviews).watch();

  /// Entries grouped by filter. Open = not yet reviewed (includes due).
  Stream<List<JournalEntry>> watch(JournalFilter filter) {
    final today = todayYmd(_now());
    return watchAll().asyncMap((entries) async {
      final reviewed = (await db.select(db.journalReviews).get())
          .map((r) => r.entryId)
          .toSet();
      final out = entries.where((e) {
        final isReviewed = reviewed.contains(e.id);
        switch (filter) {
          case JournalFilter.open:
            return !isReviewed;
          case JournalFilter.due:
            return !isReviewed && e.reviewDate.compareTo(today) <= 0;
          case JournalFilter.reviewed:
            return isReviewed;
        }
      }).toList()
        ..sort((a, b) => a.reviewDate.compareTo(b.reviewDate));
      return out;
    });
  }

  Future<JournalDetail> detail(int id) async {
    final entry =
        await (db.select(db.journalEntries)..where((e) => e.id.equals(id))).getSingle();
    final options = await (db.select(db.journalOptions)
          ..where((o) => o.entryId.equals(id))
          ..orderBy([(o) => OrderingTerm.asc(o.sortOrder)]))
        .get();
    final review = await (db.select(db.journalReviews)
          ..where((r) => r.entryId.equals(id)))
        .getSingleOrNull();
    final prediction = await (db.select(db.predictions)
          ..where((p) => p.journalEntryId.equals(id)))
        .getSingleOrNull();
    return JournalDetail(entry, options, review, prediction);
  }

  /// [options] needs at least 2 items; [choiceIndex] indexes into it.
  Future<int> create({
    required String decision,
    String? context,
    required List<String> options,
    required int choiceIndex,
    required String reasoning,
    required String expectedOutcome,
    required int confidence,
    int? tagId,
    required String reviewDate,
    bool addAsPrediction = false,
  }) {
    final cleaned = options.map((o) => o.trim()).where((o) => o.isNotEmpty).toList();
    if (cleaned.length < 2) throw ArgumentError('At least 2 options are required');
    return db.transaction(() async {
      final entryId = await db.into(db.journalEntries).insert(
            JournalEntriesCompanion.insert(
              decision: decision.trim(),
              context: Value(_blankToNull(context)),
              reasoning: reasoning.trim(),
              expectedOutcome: expectedOutcome.trim(),
              confidence: confidence,
              tagId: Value(tagId),
              reviewDate: reviewDate,
            ),
          );
      int? choiceId;
      for (var i = 0; i < cleaned.length; i++) {
        final id = await db.into(db.journalOptions).insert(
              JournalOptionsCompanion.insert(
                  entryId: entryId, body: cleaned[i], sortOrder: i),
            );
        if (i == choiceIndex) choiceId = id;
      }
      await (db.update(db.journalEntries)..where((e) => e.id.equals(entryId)))
          .write(JournalEntriesCompanion(choiceOptionId: Value(choiceId)));
      if (addAsPrediction) {
        await PredictionRepository(db, _now).create(
          statement: expectedOutcome,
          confidence: confidence,
          resolveBy: reviewDate,
          tagId: tagId,
          journalEntryId: entryId,
        );
      }
      return entryId;
    });
  }

  /// Reasoning and confidence are ignored once locked (24 h after creation).
  Future<void> update(
    int id, {
    required String decision,
    String? context,
    required List<String> options,
    required int choiceIndex,
    String? reasoning,
    required String expectedOutcome,
    int? confidence,
    int? tagId,
    required String reviewDate,
  }) async {
    final cleaned = options.map((o) => o.trim()).where((o) => o.isNotEmpty).toList();
    if (cleaned.length < 2) throw ArgumentError('At least 2 options are required');
    final existing = (await detail(id)).entry;
    final unlocked = !isLocked(existing.createdAt, _now());
    await db.transaction(() async {
      await (db.delete(db.journalOptions)..where((o) => o.entryId.equals(id))).go();
      int? choiceId;
      for (var i = 0; i < cleaned.length; i++) {
        final oid = await db.into(db.journalOptions).insert(
              JournalOptionsCompanion.insert(
                  entryId: id, body: cleaned[i], sortOrder: i),
            );
        if (i == choiceIndex) choiceId = oid;
      }
      await (db.update(db.journalEntries)..where((e) => e.id.equals(id))).write(
        JournalEntriesCompanion(
          decision: Value(decision.trim()),
          context: Value(_blankToNull(context)),
          choiceOptionId: Value(choiceId),
          expectedOutcome: Value(expectedOutcome.trim()),
          tagId: Value(tagId),
          reviewDate: Value(reviewDate),
          reasoning: unlocked && reasoning != null
              ? Value(reasoning.trim())
              : const Value.absent(),
          confidence:
              unlocked && confidence != null ? Value(confidence) : const Value.absent(),
          updatedAt: Value(_now()),
        ),
      );
    });
  }

  Future<void> postpone(int id, String newDate) =>
      (db.update(db.journalEntries)..where((e) => e.id.equals(id))).write(
        JournalEntriesCompanion(reviewDate: Value(newDate), updatedAt: Value(_now())),
      );

  /// Creates or replaces the review. If [predictionOutcome] is given, the
  /// linked prediction is resolved too.
  Future<void> saveReview(
    int entryId, {
    required String whatHappened,
    required int reasoningScore,
    String? lessons,
    String? predictionOutcome,
  }) async {
    if (reasoningScore < 1 || reasoningScore > 5) {
      throw ArgumentError('Reasoning score must be 1-5');
    }
    await db.transaction(() async {
      final existing = await (db.select(db.journalReviews)
            ..where((r) => r.entryId.equals(entryId)))
          .getSingleOrNull();
      final now = _now();
      if (existing == null) {
        await db.into(db.journalReviews).insert(JournalReviewsCompanion.insert(
              entryId: entryId,
              whatHappened: whatHappened.trim(),
              reasoningScore: reasoningScore,
              lessons: Value(_blankToNull(lessons)),
              reviewedAt: now,
            ));
      } else {
        await (db.update(db.journalReviews)..where((r) => r.id.equals(existing.id)))
            .write(JournalReviewsCompanion(
          whatHappened: Value(whatHappened.trim()),
          reasoningScore: Value(reasoningScore),
          lessons: Value(_blankToNull(lessons)),
          updatedAt: Value(now),
        ));
      }
      if (predictionOutcome != null) {
        await (db.update(db.predictions)
              ..where((p) => p.journalEntryId.equals(entryId) & p.outcome.isNull()))
            .write(PredictionsCompanion(
          outcome: Value(predictionOutcome),
          resolvedAt: Value(now),
          updatedAt: Value(now),
        ));
      }
    });
  }
}

String? _blankToNull(String? s) {
  final t = s?.trim();
  return t == null || t.isEmpty ? null : t;
}
