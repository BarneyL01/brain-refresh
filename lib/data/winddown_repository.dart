import 'dart:convert';

import 'package:drift/drift.dart';

import '../core/dates.dart';
import 'database.dart';

class WinddownRepository {
  WinddownRepository(this.db, [DateTime Function()? clock])
      : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  Stream<List<WinddownStep>> watchSteps() => (db.select(db.winddownSteps)
        ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]))
      .watch();

  Future<List<WinddownStep>> steps() => watchSteps().first;

  Future<void> addStep(String name, int? minutes) async {
    final all = await steps();
    await db.into(db.winddownSteps).insert(WinddownStepsCompanion.insert(
          name: name.trim(),
          minutes: Value(minutes),
          sortOrder: all.length,
        ));
  }

  Future<void> updateStep(int id, String name, int? minutes) =>
      (db.update(db.winddownSteps)..where((s) => s.id.equals(id))).write(
        WinddownStepsCompanion(
          name: Value(name.trim()),
          minutes: Value(minutes),
          updatedAt: Value(_now()),
        ),
      );

  Future<void> deleteStep(int id) async {
    await (db.delete(db.winddownSteps)..where((s) => s.id.equals(id))).go();
    await _renumber();
  }

  /// Moves a step to [newIndex] in the ordered list.
  Future<void> move(int id, int newIndex) async {
    final all = await steps();
    final from = all.indexWhere((s) => s.id == id);
    if (from < 0) return;
    final item = all.removeAt(from);
    all.insert(newIndex.clamp(0, all.length), item);
    await db.transaction(() async {
      for (var i = 0; i < all.length; i++) {
        await (db.update(db.winddownSteps)..where((s) => s.id.equals(all[i].id)))
            .write(WinddownStepsCompanion(sortOrder: Value(i)));
      }
    });
  }

  Future<void> _renumber() async {
    final all = await steps();
    for (var i = 0; i < all.length; i++) {
      await (db.update(db.winddownSteps)..where((s) => s.id.equals(all[i].id)))
          .write(WinddownStepsCompanion(sortOrder: Value(i)));
    }
  }

  /// Logs a run with the step names completed so far.
  Future<void> logRun(DateTime startedAt, List<String> completed) =>
      db.into(db.winddownRuns).insert(WinddownRunsCompanion.insert(
            date: todayYmd(startedAt),
            startedAt: startedAt,
            completedStepNames: jsonEncode(completed),
          ));
}
