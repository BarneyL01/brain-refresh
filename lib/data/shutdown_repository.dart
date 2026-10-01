import 'package:drift/drift.dart';

import '../core/dates.dart';
import 'database.dart';

class ShutdownRepository {
  ShutdownRepository(this.db, [DateTime Function()? clock])
      : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  Stream<List<OpenLoop>> watchOpenLoops() => (db.select(db.openLoops)
        ..where((l) => l.closedOn.isNull())
        ..orderBy([(l) => OrderingTerm.asc(l.openedOn), (l) => OrderingTerm.asc(l.id)]))
      .watch();

  Future<void> addLoop(String text, {int? sourceTaskId}) =>
      db.into(db.openLoops).insert(OpenLoopsCompanion.insert(
            body: text.trim(),
            openedOn: todayYmd(_now()),
            sourceTaskId: Value(sourceTaskId),
          ));

  Future<void> closeLoop(int id) =>
      (db.update(db.openLoops)..where((l) => l.id.equals(id))).write(
        OpenLoopsCompanion(
          closedOn: Value(todayYmd(_now())),
          updatedAt: Value(_now()),
        ),
      );

  Future<void> deleteLoop(int id) =>
      (db.delete(db.openLoops)..where((l) => l.id.equals(id))).go();

  /// Unticked tasks from [date]'s day plan that are not already open loops.
  Future<List<DayPlanTask>> suggestions(String date) async {
    final plan = await (db.select(db.dayPlans)..where((p) => p.date.equals(date)))
        .getSingleOrNull();
    if (plan == null) return [];
    final tasks = await (db.select(db.dayPlanTasks)
          ..where((t) => t.dayPlanId.equals(plan.id) & t.done.equals(false)))
        .get();
    final loops = await db.select(db.openLoops).get();
    final used = loops.map((l) => l.sourceTaskId).whereType<int>().toSet();
    return tasks.where((t) => !used.contains(t.id)).toList();
  }

  Stream<Shutdown?> watch(String date) =>
      (db.select(db.shutdowns)..where((s) => s.date.equals(date)))
          .watchSingleOrNull();

  /// Yesterday's (or latest earlier) shutdown first step, shown in the morning.
  Future<Shutdown?> latestBefore(String date) => (db.select(db.shutdowns)
        ..where((s) => s.date.isSmallerThanValue(date) & s.closedAt.isNotNull())
        ..orderBy([(s) => OrderingTerm.desc(s.date)])
        ..limit(1))
      .getSingleOrNull();

  /// Saves the first step without closing.
  Future<void> saveDraft(String date, String firstStep) async {
    final existing = await (db.select(db.shutdowns)..where((s) => s.date.equals(date)))
        .getSingleOrNull();
    if (existing == null) {
      await db.into(db.shutdowns).insert(
          ShutdownsCompanion.insert(date: date, firstStep: firstStep.trim()));
    } else {
      await (db.update(db.shutdowns)..where((s) => s.id.equals(existing.id))).write(
          ShutdownsCompanion(
              firstStep: Value(firstStep.trim()), updatedAt: Value(_now())));
    }
  }

  /// Closes the work day. The first step is required.
  Future<void> close(String date, String firstStep) async {
    if (firstStep.trim().isEmpty) {
      throw ArgumentError("Tomorrow's first step is required");
    }
    await saveDraft(date, firstStep);
    await (db.update(db.shutdowns)..where((s) => s.date.equals(date))).write(
        ShutdownsCompanion(closedAt: Value(_now()), updatedAt: Value(_now())));
  }

  Future<void> reopen(String date) =>
      (db.update(db.shutdowns)..where((s) => s.date.equals(date))).write(
          ShutdownsCompanion(closedAt: const Value(null), updatedAt: Value(_now())));
}
