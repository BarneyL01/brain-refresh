import 'package:drift/drift.dart';

import '../features/experiences/experience_calc.dart';
import 'database.dart';

class ExperienceRepository {
  ExperienceRepository(this.db, [DateTime Function()? clock])
    : _now = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() _now;

  /// Active experiences first, then finished; newest start date first in each.
  Stream<List<Experience>> watchAll() =>
      db.select(db.experiences).watch().map((list) {
        final l = list.toList()
          ..sort((a, b) {
            if (a.status != b.status) return a.status == 'active' ? -1 : 1;
            final c = b.startDate.compareTo(a.startDate);
            return c != 0 ? c : b.id.compareTo(a.id);
          });
        return l;
      });

  Stream<Experience?> watch(int id) => (db.select(
    db.experiences,
  )..where((e) => e.id.equals(id))).watchSingleOrNull();

  Future<Experience> get(int id) =>
      (db.select(db.experiences)..where((e) => e.id.equals(id))).getSingle();

  Stream<List<ExperienceParticipant>> watchParticipants(int experienceId) =>
      (db.select(db.experienceParticipants)
            ..where((p) => p.experienceId.equals(experienceId))
            ..orderBy([(p) => OrderingTerm.asc(p.id)]))
          .watch();

  Stream<List<CheckIn>> watchCheckIns(int experienceId) =>
      (db.select(db.checkIns)
            ..where((c) => c.experienceId.equals(experienceId)))
          .watch()
          .map(sortedCheckIns);

  Future<List<CheckIn>> checkIns(int experienceId) =>
      watchCheckIns(experienceId).first;

  Future<int> create({
    required String name,
    required String startDate,
    String? endDate,
    String frequency = 'manual',
    List<String> participants = const [],
  }) {
    final n = name.trim();
    if (n.isEmpty) throw ArgumentError('Name is required');
    if (endDate != null && endDate.compareTo(startDate) < 0) {
      throw ArgumentError('End date cannot be before the start date');
    }
    if (!frequencies.containsKey(frequency)) {
      throw ArgumentError('Unknown frequency');
    }
    return db.transaction(() async {
      final id = await db
          .into(db.experiences)
          .insert(
            ExperiencesCompanion.insert(
              name: n,
              startDate: startDate,
              endDate: Value(endDate),
              checkinFrequency: Value(frequency),
              createdAt: Value(_now()),
              updatedAt: Value(_now()),
            ),
          );
      for (final p
          in participants.map((p) => p.trim()).where((p) => p.isNotEmpty)) {
        await _addParticipant(id, p);
      }
      return id;
    });
  }

  Future<void> addParticipant(int experienceId, String name) async {
    if (name.trim().isEmpty) throw ArgumentError('Name is required');
    await _addParticipant(experienceId, name.trim());
  }

  Future<void> _addParticipant(int experienceId, String name) => db
      .into(db.experienceParticipants)
      .insert(
        ExperienceParticipantsCompanion.insert(
          experienceId: experienceId,
          displayName: name,
          createdAt: Value(_now()),
          updatedAt: Value(_now()),
        ),
      );

  /// Saves one check-in per entry in [ratings]. The note and marker go on the
  /// first one so a shared note is not repeated for every person.
  Future<void> addCheckIns(
    int experienceId, {
    required List<({int? participantId, int rating})> ratings,
    String? note,
    String marker = 'none',
    DateTime? at,
  }) async {
    if (ratings.isEmpty) throw ArgumentError('At least one rating is required');
    for (final r in ratings) {
      _validateRating(r.rating);
    }
    final cleanNote = _cleanNote(note);
    _validateMarker(marker);
    final exp = await get(experienceId);
    if (exp.status != 'active') throw StateError('Experience is finished');
    final when = at ?? _now();
    await db.transaction(() async {
      for (var i = 0; i < ratings.length; i++) {
        await db
            .into(db.checkIns)
            .insert(
              CheckInsCompanion.insert(
                experienceId: experienceId,
                participantId: Value(ratings[i].participantId),
                rating: ratings[i].rating,
                note: Value(i == 0 ? cleanNote : null),
                marker: Value(i == 0 ? marker : 'none'),
                checkedAt: when,
                createdAt: Value(_now()),
                updatedAt: Value(_now()),
              ),
            );
      }
    });
  }

  Future<void> updateCheckIn(
    int id, {
    required int rating,
    String? note,
    required String marker,
    required DateTime checkedAt,
  }) {
    _validateRating(rating);
    _validateMarker(marker);
    return (db.update(db.checkIns)..where((c) => c.id.equals(id))).write(
      CheckInsCompanion(
        rating: Value(rating),
        note: Value(_cleanNote(note)),
        marker: Value(marker),
        checkedAt: Value(checkedAt),
        updatedAt: Value(_now()),
      ),
    );
  }

  Future<void> deleteCheckIn(int id) =>
      (db.delete(db.checkIns)..where((c) => c.id.equals(id))).go();

  Future<void> finish(
    int id, {
    int rememberAfterDays = defaultRememberAfterDays,
  }) async {
    final e = await get(id);
    if (e.status == 'finished') return;
    final today = _now();
    final todayStr =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    await (db.update(db.experiences)..where((x) => x.id.equals(id))).write(
      ExperiencesCompanion(
        status: const Value('finished'),
        finishedAt: Value(today),
        rememberAfterDays: Value(rememberAfterDays),
        endDate: Value(e.endDate ?? todayStr),
        updatedAt: Value(today),
      ),
    );
  }

  Future<void> saveRemembered(int id, int rating) async {
    _validateRating(rating);
    final e = await get(id);
    if (e.status != 'finished') throw StateError('Experience is not finished');
    await (db.update(db.experiences)..where((x) => x.id.equals(id))).write(
      ExperiencesCompanion(
        rememberedRating: Value(rating),
        rememberedRatingAt: Value(_now()),
        updatedAt: Value(_now()),
      ),
    );
  }

  Future<void> saveDecision(int id, String decision, String? notes) {
    if (!repeatDecisions.containsKey(decision)) {
      throw ArgumentError('Unknown decision');
    }
    final n = notes?.trim();
    return (db.update(db.experiences)..where((x) => x.id.equals(id))).write(
      ExperiencesCompanion(
        repeatDecision: Value(decision),
        repeatNotes: Value(n == null || n.isEmpty ? null : n),
        updatedAt: Value(_now()),
      ),
    );
  }

  /// Earlier experiences with a similar name that have at least one check-in,
  /// most recent first.
  Future<List<Experience>> similarEarlier(String name) async {
    final all = await db.select(db.experiences).get();
    final withCheckIns = (await db.select(db.checkIns).get())
        .map((c) => c.experienceId)
        .toSet();
    return all
        .where((e) => withCheckIns.contains(e.id) && similarNames(e.name, name))
        .toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  void _validateRating(int r) {
    if (r < 1 || r > 5) throw ArgumentError('Rating must be 1-5');
  }

  void _validateMarker(String m) {
    if (!markers.containsKey(m)) throw ArgumentError('Unknown marker');
  }

  String? _cleanNote(String? note) {
    final n = note?.trim();
    if (n == null || n.isEmpty) return null;
    if (n.length > checkInNoteMax) {
      throw ArgumentError('Note is limited to $checkInNoteMax characters');
    }
    return n;
  }
}
