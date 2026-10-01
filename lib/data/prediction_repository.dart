import 'package:drift/drift.dart';

import '../core/dates.dart';
import '../core/rules.dart';
import 'database.dart';

enum PredictionFilter { open, due, resolved }

class PredictionRepository {
  PredictionRepository(this.db, [DateTime Function()? clock])
      : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  Stream<List<Prediction>> watch(PredictionFilter filter) {
    final q = db.select(db.predictions);
    final today = todayYmd(_now());
    switch (filter) {
      case PredictionFilter.open:
        q.where((p) => p.outcome.isNull());
      case PredictionFilter.due:
        q.where((p) => p.outcome.isNull() & p.resolveBy.isSmallerOrEqualValue(today));
      case PredictionFilter.resolved:
        q.where((p) => p.outcome.isNotNull());
    }
    q.orderBy([(p) => OrderingTerm.asc(p.resolveBy)]);
    return q.watch();
  }

  Stream<List<Prediction>> watchAll() => db.select(db.predictions).watch();

  Future<Prediction> get(int id) =>
      (db.select(db.predictions)..where((p) => p.id.equals(id))).getSingle();

  Future<List<PredictionDateChange>> history(int id) =>
      (db.select(db.predictionDateChanges)
            ..where((c) => c.predictionId.equals(id))
            ..orderBy([(c) => OrderingTerm.asc(c.createdAt)]))
          .get();

  Future<int> create({
    required String statement,
    required int confidence,
    required String resolveBy,
    int? tagId,
    int? journalEntryId,
  }) {
    if (resolveBy.compareTo(todayYmd(_now())) < 0) {
      throw ArgumentError('Resolve-by date must be today or later');
    }
    return db.into(db.predictions).insert(PredictionsCompanion.insert(
          statement: statement.trim(),
          confidence: confidence,
          resolveBy: resolveBy,
          tagId: Value(tagId),
          journalEntryId: Value(journalEntryId),
        ));
  }

  /// Statement and tag are always editable. Confidence is ignored once the
  /// prediction is locked (24 h after creation).
  Future<void> update(
    int id, {
    required String statement,
    int? tagId,
    int? confidence,
  }) async {
    final p = await get(id);
    final canChangeConfidence = !isLocked(p.createdAt, _now());
    await (db.update(db.predictions)..where((t) => t.id.equals(id))).write(
      PredictionsCompanion(
        statement: Value(statement.trim()),
        tagId: Value(tagId),
        confidence: confidence != null && canChangeConfidence
            ? Value(confidence)
            : const Value.absent(),
        updatedAt: Value(_now()),
      ),
    );
  }

  /// Extends the resolve-by date and records the change.
  Future<void> extendDate(int id, String newDate) async {
    final p = await get(id);
    if (newDate.compareTo(p.resolveBy) <= 0) {
      throw ArgumentError('New date must be after the current resolve-by date');
    }
    await db.transaction(() async {
      await db.into(db.predictionDateChanges).insert(
            PredictionDateChangesCompanion.insert(
              predictionId: id,
              oldDate: p.resolveBy,
              newDate: newDate,
            ),
          );
      await (db.update(db.predictions)..where((t) => t.id.equals(id))).write(
        PredictionsCompanion(resolveBy: Value(newDate), updatedAt: Value(_now())),
      );
    });
  }

  Future<void> resolve(int id, String outcome) =>
      (db.update(db.predictions)..where((t) => t.id.equals(id))).write(
        PredictionsCompanion(
          outcome: Value(outcome),
          resolvedAt: Value(_now()),
          updatedAt: Value(_now()),
        ),
      );

  Future<void> reopen(int id) =>
      (db.update(db.predictions)..where((t) => t.id.equals(id))).write(
        PredictionsCompanion(
          outcome: const Value(null),
          resolvedAt: const Value(null),
          updatedAt: Value(_now()),
        ),
      );
}
