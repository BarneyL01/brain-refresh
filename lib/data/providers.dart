import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backup_repository.dart';
import 'database.dart';
import 'dayplan_repository.dart';
import 'journal_repository.dart';
import 'prediction_repository.dart';
import 'shutdown_repository.dart';
import 'tag_repository.dart';
import 'winddown_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) => throw UnimplementedError());
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

final tagRepoProvider = Provider((ref) => TagRepository(ref.watch(databaseProvider)));
final predictionRepoProvider =
    Provider((ref) => PredictionRepository(ref.watch(databaseProvider)));
final journalRepoProvider = Provider((ref) => JournalRepository(ref.watch(databaseProvider)));
final dayPlanRepoProvider = Provider((ref) => DayPlanRepository(ref.watch(databaseProvider)));
final shutdownRepoProvider = Provider((ref) => ShutdownRepository(ref.watch(databaseProvider)));
final winddownRepoProvider = Provider((ref) => WinddownRepository(ref.watch(databaseProvider)));
final backupRepoProvider = Provider((ref) => BackupRepository(ref.watch(databaseProvider)));

final tagsProvider = StreamProvider((ref) => ref.watch(tagRepoProvider).watchAll());
final allPredictionsProvider =
    StreamProvider((ref) => ref.watch(predictionRepoProvider).watchAll());
final allJournalProvider = StreamProvider((ref) => ref.watch(journalRepoProvider).watchAll());
final allReviewsProvider = StreamProvider((ref) => ref.watch(journalRepoProvider).watchReviews());
final predictionsByFilter = StreamProvider.family(
    (ref, PredictionFilter f) => ref.watch(predictionRepoProvider).watch(f));
final journalByFilter = StreamProvider.family(
    (ref, JournalFilter f) => ref.watch(journalRepoProvider).watch(f));
final dayPlanProvider = StreamProvider.family(
    (ref, String date) => ref.watch(dayPlanRepoProvider).watch(date));
final openLoopsProvider = StreamProvider((ref) => ref.watch(shutdownRepoProvider).watchOpenLoops());
final shutdownProvider =
    StreamProvider.family((ref, String date) => ref.watch(shutdownRepoProvider).watch(date));
final windDownStepsProvider = StreamProvider((ref) => ref.watch(winddownRepoProvider).watchSteps());

const _lastExportKey = 'lastExport';
const _eveningKey = 'todayEvening';

String? lastExport(SharedPreferences p) => p.getString(_lastExportKey);
Future<void> setLastExport(SharedPreferences p, DateTime d) =>
    p.setString(_lastExportKey, d.toIso8601String());
bool isEvening(SharedPreferences p) => p.getBool(_eveningKey) ?? false;
Future<void> setEvening(SharedPreferences p, bool v) => p.setBool(_eveningKey, v);
