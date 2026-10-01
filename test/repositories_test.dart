import 'package:brain_refresh/data/backup_repository.dart';
import 'package:brain_refresh/data/database.dart';
import 'package:brain_refresh/data/dayplan_repository.dart';
import 'package:brain_refresh/data/journal_repository.dart';
import 'package:brain_refresh/data/prediction_repository.dart';
import 'package:brain_refresh/data/shutdown_repository.dart';
import 'package:brain_refresh/data/tag_repository.dart';
import 'package:brain_refresh/data/winddown_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  var now = DateTime(2026, 10, 1, 9);
  DateTime clock() => now;

  setUp(() {
    now = DateTime(2026, 10, 1, 9);
    db = AppDatabase(NativeDatabase.memory());
  });
  tearDown(() => db.close());

  test('prediction confidence locks after 24h, date extension recorded', () async {
    final repo = PredictionRepository(db, clock);
    final id = await repo.create(
        statement: 'It rains', confidence: 70, resolveBy: '2026-10-05');
    await repo.update(id, statement: 'It rains tomorrow', confidence: 80);
    expect((await repo.get(id)).confidence, 80);

    now = now.add(const Duration(hours: 25));
    await repo.update(id, statement: 'It rains tomorrow', confidence: 55);
    expect((await repo.get(id)).confidence, 80);

    await repo.extendDate(id, '2026-10-09');
    final hist = await repo.history(id);
    expect(hist.single.oldDate, '2026-10-05');
    expect(hist.single.newDate, '2026-10-09');

    expect(
      () => repo.create(statement: 'x', confidence: 70, resolveBy: '2026-09-30'),
      throwsArgumentError,
    );
  });

  test('prediction due, resolve, reopen', () async {
    final repo = PredictionRepository(db, clock);
    final id = await repo.create(
        statement: 'A', confidence: 60, resolveBy: '2026-10-01');
    expect(await repo.watch(PredictionFilter.due).first, hasLength(1));
    await repo.resolve(id, 'true');
    expect(await repo.watch(PredictionFilter.resolved).first, hasLength(1));
    expect(await repo.watch(PredictionFilter.open).first, isEmpty);
    await repo.reopen(id);
    expect((await repo.get(id)).outcome, isNull);
  });

  test('journal create with linked prediction, review resolves it', () async {
    final repo = JournalRepository(db, clock);
    final id = await repo.create(
      decision: 'Take job',
      options: ['Take', 'Stay'],
      choiceIndex: 0,
      reasoning: 'Growth',
      expectedOutcome: 'Happier',
      confidence: 70,
      reviewDate: '2026-11-01',
      addAsPrediction: true,
    );
    var d = await repo.detail(id);
    expect(d.options, hasLength(2));
    expect(d.entry.choiceOptionId, d.options.first.id);
    expect(d.prediction?.resolveBy, '2026-11-01');

    expect(
      () => repo.create(
        decision: 'x',
        options: ['only'],
        choiceIndex: 0,
        reasoning: 'r',
        expectedOutcome: 'e',
        confidence: 70,
        reviewDate: '2026-11-01',
      ),
      throwsArgumentError,
    );

    now = DateTime(2026, 11, 2);
    expect(await repo.watch(JournalFilter.due).first, hasLength(1));
    await repo.saveReview(id,
        whatHappened: 'ok', reasoningScore: 4, predictionOutcome: 'true');
    d = await repo.detail(id);
    expect(d.review?.reasoningScore, 4);
    expect(d.prediction?.outcome, 'true');
    expect(await repo.watch(JournalFilter.reviewed).first, hasLength(1));
    expect(await repo.watch(JournalFilter.due).first, isEmpty);
  });

  test('day plan: one per date, done kept, defaults replaced', () async {
    final repo = DayPlanRepository(db);
    await repo.save('2026-10-02',
        tasks: ['A', 'B'], defaults: [(label: 'Dinner', choice: 'Leftovers')]);
    var v = (await repo.get('2026-10-02'))!;
    await repo.setDone(v.tasks.first.id, true);
    await repo.save('2026-10-02',
        tasks: ['A', 'C'], defaults: [(label: 'Dinner', choice: 'Pasta')]);
    v = (await repo.get('2026-10-02'))!;
    expect(v.tasks.map((t) => (t.body, t.done)), [('A', true), ('C', false)]);
    expect(v.defaults.single.choice, 'Pasta');
    expect(await db.select(db.dayPlans).get(), hasLength(1));
    expect(await repo.knownLabels(), ['Dinner']);
    expect(() => repo.save('2026-10-03', tasks: ['1', '2', '3', '4'], defaults: []),
        throwsArgumentError);
  });

  test('shutdown: suggestions, first step required, loops carry', () async {
    final plans = DayPlanRepository(db);
    final repo = ShutdownRepository(db, clock);
    await plans.save('2026-10-01', tasks: ['A', 'B'], defaults: []);
    final tasks = (await plans.get('2026-10-01'))!.tasks;
    await plans.setDone(tasks.first.id, true);

    var s = await repo.suggestions('2026-10-01');
    expect(s.map((t) => t.body), ['B']);
    await repo.addLoop(s.single.body, sourceTaskId: s.single.id);
    expect(await repo.suggestions('2026-10-01'), isEmpty);

    expect(() => repo.close('2026-10-01', '  '), throwsArgumentError);
    await repo.close('2026-10-01', 'Call Bob');
    final sd = await repo.watch('2026-10-01').first;
    expect(sd?.closedAt, isNotNull);
    await repo.reopen('2026-10-01');
    expect((await repo.watch('2026-10-01').first)?.closedAt, isNull);
    await repo.close('2026-10-01', 'Call Bob');
    expect((await repo.latestBefore('2026-10-02'))?.firstStep, 'Call Bob');

    now = DateTime(2026, 10, 4);
    final loops = await repo.watchOpenLoops().first;
    expect(loops.single.openedOn, '2026-10-01');
  });

  test('wind-down steps ordering and run log', () async {
    final repo = WinddownRepository(db, clock);
    await repo.addStep('Walk', 15);
    await repo.addStep('Breathing', 5);
    await repo.addStep('Phone on charger', null);
    final ids = (await repo.steps()).map((s) => s.id).toList();
    await repo.move(ids.last, 0);
    expect((await repo.steps()).map((s) => s.name),
        ['Phone on charger', 'Walk', 'Breathing']);
    await repo.deleteStep(ids.first);
    expect((await repo.steps()).map((s) => s.sortOrder), [0, 1]);
    await repo.logRun(now, ['Phone on charger']);
    expect((await db.select(db.winddownRuns).get()).single.completedStepNames,
        '["Phone on charger"]');
  });

  test('tags: delete only when unused', () async {
    final tags = TagRepository(db);
    final t = await tags.add('Work');
    await PredictionRepository(db, clock).create(
        statement: 'x', confidence: 70, resolveBy: '2026-10-02', tagId: t);
    expect(await tags.deleteIfUnused(t), isFalse);
    final u = await tags.add('Unused');
    expect(await tags.deleteIfUnused(u), isTrue);
  });

  test('backup round trip and rejection of newer schema', () async {
    final tags = TagRepository(db);
    final t = await tags.add('Work');
    final preds = PredictionRepository(db, clock);
    final p = await preds.create(
        statement: 'x', confidence: 70, resolveBy: '2026-10-02', tagId: t);
    await preds.resolve(p, 'false');
    await JournalRepository(db, clock).create(
      decision: 'd',
      options: ['a', 'b'],
      choiceIndex: 1,
      reasoning: 'r',
      expectedOutcome: 'e',
      confidence: 60,
      reviewDate: '2026-11-01',
    );
    await DayPlanRepository(db)
        .save('2026-10-02', tasks: ['A'], defaults: [(label: 'L', choice: 'C')]);
    await WinddownRepository(db, clock).addStep('Walk', 15);

    final backup = BackupRepository(db, clock);
    final json = await backup.exportJson();
    final summary = backup.summarize(json);
    expect(summary.counts['predictions'], 1);
    expect(summary.counts['journal_options'], 2);
    expect(summary.counts.length, 13);

    // Change data, then restore.
    await preds.reopen(p);
    await tags.add('Extra');
    await backup.import(json);
    expect((await preds.get(p)).outcome, 'false');
    expect(await db.select(db.tags).get(), hasLength(1));
    expect(await backup.exportJson(), json);

    final newer = json.replaceFirst('"schemaVersion":1', '"schemaVersion":99');
    expect(() => backup.summarize(newer), throwsA(isA<BackupException>()));
    expect(() => backup.summarize('nope'), throwsA(isA<BackupException>()));
  });
}
