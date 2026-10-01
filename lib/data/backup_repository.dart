import 'dart:convert';

import 'package:drift/drift.dart';

import 'database.dart';

class BackupSummary {
  BackupSummary(this.schemaVersion, this.exportedAt, this.counts);
  final int schemaVersion;
  final DateTime exportedAt;
  final Map<String, int> counts;
}

class BackupException implements Exception {
  BackupException(this.message);
  final String message;
  @override
  String toString() => message;
}

class BackupRepository {
  BackupRepository(this.db, [DateTime Function()? clock])
      : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  Future<Map<String, List<Map<String, Object?>>>> _dump() async => {
        'tags': [for (final r in await db.select(db.tags).get()) r.toJson()],
        'predictions': [for (final r in await db.select(db.predictions).get()) r.toJson()],
        'prediction_date_changes': [
          for (final r in await db.select(db.predictionDateChanges).get()) r.toJson()
        ],
        'journal_entries': [
          for (final r in await db.select(db.journalEntries).get()) r.toJson()
        ],
        'journal_options': [
          for (final r in await db.select(db.journalOptions).get()) r.toJson()
        ],
        'journal_reviews': [
          for (final r in await db.select(db.journalReviews).get()) r.toJson()
        ],
        'day_plans': [for (final r in await db.select(db.dayPlans).get()) r.toJson()],
        'day_plan_tasks': [
          for (final r in await db.select(db.dayPlanTasks).get()) r.toJson()
        ],
        'day_plan_defaults': [
          for (final r in await db.select(db.dayPlanDefaults).get()) r.toJson()
        ],
        'open_loops': [for (final r in await db.select(db.openLoops).get()) r.toJson()],
        'shutdowns': [for (final r in await db.select(db.shutdowns).get()) r.toJson()],
        'winddown_steps': [
          for (final r in await db.select(db.winddownSteps).get()) r.toJson()
        ],
        'winddown_runs': [
          for (final r in await db.select(db.winddownRuns).get()) r.toJson()
        ],
      };

  Future<String> exportJson() async => jsonEncode({
        'schemaVersion': AppDatabase.currentSchemaVersion,
        'exportedAt': _now().toIso8601String(),
        'tables': await _dump(),
      });

  /// Parses and validates a backup file without changing any data.
  BackupSummary summarize(String json) {
    final map = _parse(json);
    final tables = map['tables'] as Map<String, dynamic>;
    return BackupSummary(
      map['schemaVersion'] as int,
      DateTime.parse(map['exportedAt'] as String),
      {for (final e in tables.entries) e.key: (e.value as List).length},
    );
  }

  Map<String, dynamic> _parse(String json) {
    final Object? decoded;
    try {
      decoded = jsonDecode(json);
    } catch (_) {
      throw BackupException('Not a valid JSON file');
    }
    if (decoded is! Map<String, dynamic> ||
        decoded['schemaVersion'] is! int ||
        decoded['exportedAt'] is! String ||
        decoded['tables'] is! Map) {
      throw BackupException('Not a backup file from this app');
    }
    if ((decoded['schemaVersion'] as int) > AppDatabase.currentSchemaVersion) {
      throw BackupException(
          'Backup is from a newer app version (schema ${decoded['schemaVersion']}); '
          'update the app first');
    }
    return decoded;
  }

  /// Replaces all current data with the backup's. The caller is responsible
  /// for exporting the current data first.
  Future<void> import(String json) async {
    final map = _parse(json);
    final t = map['tables'] as Map<String, dynamic>;
    List<Map<String, dynamic>> rows(String name) =>
        [for (final r in (t[name] as List? ?? const [])) r as Map<String, dynamic>];

    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
      Future<void> load<T extends Table, D>(
        TableInfo<T, D> table,
        String name,
        D Function(Map<String, dynamic>) fromJson,
      ) async {
        for (final r in rows(name)) {
          await db.into(table).insert(fromJson(r) as Insertable<D>);
        }
      }

      await load(db.tags, 'tags', Tag.fromJson);
      await load(db.predictions, 'predictions', Prediction.fromJson);
      await load(db.predictionDateChanges, 'prediction_date_changes',
          PredictionDateChange.fromJson);
      await load(db.journalEntries, 'journal_entries', JournalEntry.fromJson);
      await load(db.journalOptions, 'journal_options', JournalOption.fromJson);
      await load(db.journalReviews, 'journal_reviews', JournalReview.fromJson);
      await load(db.dayPlans, 'day_plans', DayPlan.fromJson);
      await load(db.dayPlanTasks, 'day_plan_tasks', DayPlanTask.fromJson);
      await load(db.dayPlanDefaults, 'day_plan_defaults', DayPlanDefault.fromJson);
      await load(db.openLoops, 'open_loops', OpenLoop.fromJson);
      await load(db.shutdowns, 'shutdowns', Shutdown.fromJson);
      await load(db.winddownSteps, 'winddown_steps', WinddownStep.fromJson);
      await load(db.winddownRuns, 'winddown_runs', WinddownRun.fromJson);
    });
  }
}
