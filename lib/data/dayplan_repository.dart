import 'package:drift/drift.dart';

import 'database.dart';

class DayPlanView {
  DayPlanView(this.plan, this.tasks, this.defaults);
  final DayPlan plan;
  final List<DayPlanTask> tasks;
  final List<DayPlanDefault> defaults;
}

class DayPlanRepository {
  DayPlanRepository(this.db);
  final AppDatabase db;

  Stream<DayPlanView?> watch(String date) {
    final planQ = db.select(db.dayPlans)..where((p) => p.date.equals(date));
    return planQ.watchSingleOrNull().asyncExpand((plan) {
      if (plan == null) return Stream.value(null);
      final tasks = (db.select(db.dayPlanTasks)
            ..where((t) => t.dayPlanId.equals(plan.id))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();
      return tasks.asyncMap((t) async {
        final defaults = await (db.select(db.dayPlanDefaults)
              ..where((d) => d.dayPlanId.equals(plan.id))
              ..orderBy([(d) => OrderingTerm.asc(d.sortOrder)]))
            .get();
        return DayPlanView(plan, t, defaults);
      });
    });
  }

  Future<DayPlanView?> get(String date) => watch(date).first;

  /// One plan per date. Replaces the plan's tasks and defaults, keeping the
  /// done state of tasks whose text is unchanged.
  Future<void> save(
    String date, {
    required List<String> tasks,
    required List<({String label, String choice})> defaults,
  }) async {
    final cleanTasks = tasks.map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    if (cleanTasks.length > 3) throw ArgumentError('At most 3 tasks');
    await db.transaction(() async {
      var plan = await (db.select(db.dayPlans)..where((p) => p.date.equals(date)))
          .getSingleOrNull();
      plan ??= await db
          .into(db.dayPlans)
          .insertReturning(DayPlansCompanion.insert(date: date));
      final old = await (db.select(db.dayPlanTasks)
            ..where((t) => t.dayPlanId.equals(plan!.id)))
          .get();
      final doneTexts = {for (final t in old.where((t) => t.done)) t.body};
      await (db.delete(db.dayPlanTasks)..where((t) => t.dayPlanId.equals(plan!.id))).go();
      await (db.delete(db.dayPlanDefaults)..where((d) => d.dayPlanId.equals(plan!.id)))
          .go();
      for (var i = 0; i < cleanTasks.length; i++) {
        await db.into(db.dayPlanTasks).insert(DayPlanTasksCompanion.insert(
              dayPlanId: plan.id,
              body: cleanTasks[i],
              done: Value(doneTexts.contains(cleanTasks[i])),
              sortOrder: i,
            ));
      }
      var i = 0;
      for (final d in defaults) {
        if (d.label.trim().isEmpty || d.choice.trim().isEmpty) continue;
        await db.into(db.dayPlanDefaults).insert(DayPlanDefaultsCompanion.insert(
              dayPlanId: plan.id,
              label: d.label.trim(),
              choice: d.choice.trim(),
              sortOrder: i++,
            ));
      }
    });
  }

  Future<void> setDone(int taskId, bool done) =>
      (db.update(db.dayPlanTasks)..where((t) => t.id.equals(taskId))).write(
        DayPlanTasksCompanion(done: Value(done), updatedAt: Value(DateTime.now())),
      );

  /// Previously used default labels, most recent first, for quick picks.
  Future<List<String>> knownLabels() async {
    final rows = await (db.select(db.dayPlanDefaults)
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
    final seen = <String>{};
    return [for (final r in rows) if (seen.add(r.label)) r.label];
  }
}
