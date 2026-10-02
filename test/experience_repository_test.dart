import 'package:brain_refresh/data/database.dart';
import 'package:brain_refresh/data/experience_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sql;

void main() {
  late AppDatabase db;
  var now = DateTime(2026, 7, 1, 20);
  late ExperienceRepository repo;

  setUp(() {
    now = DateTime(2026, 7, 1, 20);
    db = AppDatabase(NativeDatabase.memory());
    repo = ExperienceRepository(db, () => now);
  });
  tearDown(() => db.close());

  test('create validates and stores participants', () async {
    expect(
      () => repo.create(name: ' ', startDate: '2026-07-01'),
      throwsArgumentError,
    );
    expect(
      () => repo.create(
        name: 'x',
        startDate: '2026-07-02',
        endDate: '2026-07-01',
      ),
      throwsArgumentError,
    );
    final id = await repo.create(
      name: 'Camping',
      startDate: '2026-07-01',
      participants: ['Sam', ' ', 'Alex'],
    );
    expect((await repo.watchParticipants(id).first).map((p) => p.displayName), [
      'Sam',
      'Alex',
    ]);
    expect((await repo.get(id)).status, 'active');
  });

  test(
    'check-in without a note saves; shared note goes on the first one',
    () async {
      final id = await repo.create(
        name: 'Camping',
        startDate: '2026-07-01',
        participants: ['Sam'],
      );
      final sam = (await repo.watchParticipants(id).first).single.id;
      await repo.addCheckIns(id, ratings: [(participantId: null, rating: 4)]);
      await repo.addCheckIns(
        id,
        ratings: [
          (participantId: null, rating: 5),
          (participantId: sam, rating: 3),
        ],
        note: '  Great day  ',
        marker: 'high',
      );
      final list = await repo.checkIns(id);
      expect(list, hasLength(3));
      expect(list[0].note, isNull);
      final withNote = list.where((c) => c.note != null).toList();
      expect(withNote, hasLength(1));
      expect(withNote.single.note, 'Great day');
      expect(withNote.single.marker, 'high');
    },
  );

  test('check-in validation and timestamp edit', () async {
    final id = await repo.create(name: 'Camping', startDate: '2026-07-01');
    expect(
      () => repo.addCheckIns(id, ratings: [(participantId: null, rating: 6)]),
      throwsArgumentError,
    );
    expect(
      () => repo.addCheckIns(id, ratings: [(participantId: null, rating: 0)]),
      throwsArgumentError,
    );
    expect(() => repo.addCheckIns(id, ratings: []), throwsArgumentError);
    expect(
      () => repo.addCheckIns(
        id,
        ratings: [(participantId: null, rating: 3)],
        note: 'x' * 201,
      ),
      throwsArgumentError,
    );
    await repo.addCheckIns(
      id,
      ratings: [(participantId: null, rating: 3)],
      note: 'x' * 200,
    );
    final c = (await repo.checkIns(id)).single;
    final earlier = DateTime(2026, 6, 30, 8);
    await repo.updateCheckIn(
      c.id,
      rating: 4,
      note: null,
      marker: 'low',
      checkedAt: earlier,
    );
    final u = (await repo.checkIns(id)).single;
    expect(
      (u.rating, u.note, u.marker, u.checkedAt),
      (4, null, 'low', earlier),
    );
    await repo.deleteCheckIn(c.id);
    expect(await repo.checkIns(id), isEmpty);
  });

  test('finish, remembered rating and decision', () async {
    final id = await repo.create(name: 'Camping', startDate: '2026-07-01');
    expect(() => repo.saveRemembered(id, 3), throwsStateError);
    await repo.addCheckIns(id, ratings: [(participantId: null, rating: 4)]);
    await repo.finish(id, rememberAfterDays: 3);
    var e = await repo.get(id);
    expect(e.status, 'finished');
    expect(e.finishedAt, now);
    expect(e.rememberAfterDays, 3);
    expect(e.endDate, '2026-07-01');
    expect(
      () => repo.addCheckIns(id, ratings: [(participantId: null, rating: 4)]),
      throwsStateError,
    );
    expect(() => repo.saveRemembered(id, 9), throwsArgumentError);
    await repo.saveRemembered(id, 2);
    await repo.saveDecision(id, 'yes_with_changes', ' Go earlier ');
    e = await repo.get(id);
    expect(
      (e.rememberedRating, e.repeatDecision, e.repeatNotes),
      (2, 'yes_with_changes', 'Go earlier'),
    );
    expect(() => repo.saveDecision(id, 'maybe', null), throwsArgumentError);
  });

  test('similar earlier experiences need check-ins', () async {
    final a = await repo.create(
      name: 'Family camping trip 2026',
      startDate: '2026-07-01',
    );
    await repo.create(
      name: 'Camping trip 2025',
      startDate: '2025-07-01',
    ); // no check-ins
    expect(await repo.similarEarlier('Camping trip 2027'), isEmpty);
    await repo.addCheckIns(a, ratings: [(participantId: null, rating: 4)]);
    final s = await repo.similarEarlier('Camping trip 2027');
    expect(s.map((e) => e.id), [a]);
    expect(await repo.similarEarlier('Gym membership'), isEmpty);
  });

  test('upgrade from schema 1 keeps data and adds the new tables', () async {
    final raw = sql.sqlite3.openInMemory()
      ..execute(
        '''CREATE TABLE "tags" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "created_at" INTEGER NOT NULL DEFAULT (strftime('%s', CURRENT_TIMESTAMP)),
        "updated_at" INTEGER NOT NULL DEFAULT (strftime('%s', CURRENT_TIMESTAMP)),
        "name" TEXT NOT NULL UNIQUE)''',
      )
      ..execute("INSERT INTO tags (name) VALUES ('Work')")
      ..execute('PRAGMA user_version = 1');
    final old = AppDatabase(NativeDatabase.opened(raw));
    addTearDown(old.close);
    expect((await old.select(old.tags).get()).single.name, 'Work');
    final r = ExperienceRepository(old, () => now);
    final id = await r.create(name: 'Trip', startDate: '2026-07-01');
    await r.addCheckIns(id, ratings: [(participantId: null, rating: 3)]);
    expect(await r.checkIns(id), hasLength(1));
  });
}
