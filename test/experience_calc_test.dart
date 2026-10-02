import 'package:brain_refresh/data/database.dart';
import 'package:brain_refresh/features/experiences/experience_calc.dart';
import 'package:flutter_test/flutter_test.dart';

int _id = 0;
CheckIn ci(
  int rating,
  DateTime at, {
  int? who,
  String? note,
  String marker = 'none',
}) => CheckIn(
  id: ++_id,
  createdAt: at,
  updatedAt: at,
  experienceId: 1,
  participantId: who,
  rating: rating,
  note: note,
  marker: marker,
  checkedAt: at,
);

Experience exp({
  String status = 'active',
  DateTime? finishedAt,
  int days = 7,
  int? remembered,
  String? decision,
  String? notes,
}) => Experience(
  id: 1,
  createdAt: DateTime(2026, 7, 1),
  updatedAt: DateTime(2026, 7, 1),
  name: 'Family camping trip 2026',
  startDate: '2026-07-01',
  endDate: '2026-07-06',
  status: status,
  checkinFrequency: 'daily',
  finishedAt: finishedAt,
  rememberAfterDays: days,
  rememberedRating: remembered,
  rememberedRatingAt: null,
  repeatDecision: decision,
  repeatNotes: notes,
);

void main() {
  final trip = [
    ci(5, DateTime(2026, 7, 1, 20)),
    ci(4, DateTime(2026, 7, 2, 20)),
    ci(4, DateTime(2026, 7, 3, 20)),
    ci(5, DateTime(2026, 7, 4, 20)),
    ci(4, DateTime(2026, 7, 5, 20)),
    ci(
      2,
      DateTime(2026, 7, 6, 20),
      note: 'Rain, packing up | late',
      marker: 'low',
    ),
  ];

  test('summary numbers', () {
    final s = summarize(trip.reversed)!;
    expect(s.total, 6);
    expect(s.average, closeTo(4.0, 1e-9));
    expect(s.positiveCount, 5);
    expect(s.positiveShare, closeTo(5 / 6, 1e-9));
    expect(s.lowest, 2);
    expect(s.highest, 5);
    expect(s.ending, 2);
    expect(summarize([]), isNull);
  });

  test(
    'ending rating is the most recent check-in, whatever the input order',
    () {
      final s = summarize([trip.last, trip.first])!;
      expect(s.ending, 2);
    },
  );

  test('per participant averages', () {
    final a = averageByParticipant([
      ci(5, DateTime(2026, 7, 1)),
      ci(3, DateTime(2026, 7, 1), who: 7),
      ci(1, DateTime(2026, 7, 2), who: 7),
    ]);
    expect(a[null], 5);
    expect(a[7], 2);
  });

  test('gap shows only at 1 point or more', () {
    expect(showGap(gapOf(3, 4.0)), isTrue); // exactly 1.0
    expect(showGap(gapOf(5, 4.0)), isTrue);
    expect(showGap(gapOf(4, 4.6)), isFalse);
    expect(showGap(gapOf(3, 3.9)), isFalse);
    expect(showGap(gapOf(null, 4.0)), isFalse);
    expect(showGap(gapOf(2, null)), isFalse);
  });

  test('gap message states the numbers side by side', () {
    final s = summarize(trip)!;
    expect(
      gapMessage(2, s),
      'You now rate this 2/5. While it was happening, your average was 4.0/5, '
      'and 5 of 6 check-ins were rated Good or Very good. '
      'Your lowest rating was on the last check-in.',
    );
    final noLowEnd = summarize([
      ci(2, DateTime(2026, 7, 1)),
      ci(5, DateTime(2026, 7, 2)),
    ])!;
    expect(gapMessage(1, noLowEnd).contains('last check-in'), isFalse);
  });

  test('remembered rating becomes due after the wait, only once', () {
    final fin = DateTime(2026, 7, 6, 12);
    final e = exp(status: 'finished', finishedAt: fin);
    expect(isRememberedDue(e, DateTime(2026, 7, 13, 11, 59)), isFalse);
    expect(isRememberedDue(e, DateTime(2026, 7, 13, 12)), isTrue);
    expect(
      isRememberedDue(
        exp(status: 'finished', finishedAt: fin, remembered: 3),
        DateTime(2026, 8, 1),
      ),
      isFalse,
    );
    expect(isRememberedDue(exp(), DateTime(2026, 8, 1)), isFalse);
    expect(rememberedUnlockAt(e), DateTime(2026, 7, 13, 12));
  });

  test('timeline breaks at missed days for daily, not otherwise', () {
    final items = [
      ci(4, DateTime(2026, 7, 1, 9)),
      ci(4, DateTime(2026, 7, 2, 23)),
      ci(3, DateTime(2026, 7, 5, 8)), // 3 and 4 July missed
      ci(5, DateTime(2026, 7, 6, 8)),
    ];
    final daily = splitRuns(items, breakOnMissedDay: true);
    expect(daily.map((r) => r.length), [2, 2]);
    expect(splitRuns(items, breakOnMissedDay: false).map((r) => r.length), [4]);
    expect(splitRuns([], breakOnMissedDay: true), isEmpty);
  });

  test('similar names', () {
    expect(
      similarNames('Camping trip 2027', 'Family camping trip 2026'),
      isTrue,
    );
    expect(similarNames('Camping trip 2027', 'Camping trip 2026'), isTrue);
    expect(similarNames('Camping trip', 'Gym membership'), false);
    expect(similarNames('2027', '2026'), isFalse);
  });

  test('markdown contains the full record and escapes table pipes', () {
    final md = lookBackMarkdown(
      experience: exp(
        status: 'finished',
        finishedAt: DateTime(2026, 7, 6),
        remembered: 2,
        decision: 'yes_with_changes',
        notes: 'Leave a day earlier',
      ),
      participants: [],
      checkIns: trip,
      now: DateTime(2026, 7, 20),
    );
    expect(md, startsWith('# Family camping trip 2026\n'));
    expect(md, contains('| Average while it was happening | 4.0 / 5 |'));
    expect(md, contains('| Rated Good or Very good | 5 of 6 (83%) |'));
    expect(md, contains('| Remembered rating | 2 / 5 |'));
    expect(md, contains('You now rate this 2/5.'));
    expect(md, contains(r'Rain, packing up \| late'));
    expect(md, contains('| 2026-07-06 20:00 | Me | 2 Bad | Low point |'));
    expect(md, contains('**Yes, with changes**'));
    expect(md, contains('What I would change: Leave a day earlier'));
    expect(md, contains('_Exported from Brain Refresh on 2026-07-20._'));
  });

  test('markdown uses an unsaved decision when given', () {
    final md = lookBackMarkdown(
      experience: exp(status: 'finished', remembered: 4),
      participants: [],
      checkIns: trip,
      now: DateTime(2026, 7, 20),
      decision: 'no',
      decisionNotes: 'Too wet',
    );
    expect(md, contains('**No**'));
    expect(md, contains('What I would change: Too wet'));
  });

  test('markdown by person when there are participants', () {
    final md = lookBackMarkdown(
      experience: exp(),
      participants: [
        ExperienceParticipant(
          id: 7,
          createdAt: DateTime(2026, 7, 1),
          updatedAt: DateTime(2026, 7, 1),
          experienceId: 1,
          displayName: 'Sam',
        ),
      ],
      checkIns: [
        ci(5, DateTime(2026, 7, 1)),
        ci(3, DateTime(2026, 7, 1), who: 7),
      ],
      now: DateTime(2026, 7, 20),
    );
    expect(md, contains('| Me | 1 | 5.0 / 5 |'));
    expect(md, contains('| Sam | 1 | 3.0 / 5 |'));
  });

  test('markdown omits gap and decision when not applicable', () {
    final md = lookBackMarkdown(
      experience: exp(remembered: 4),
      participants: [],
      checkIns: trip,
      now: DateTime(2026, 7, 20),
    );
    expect(md, isNot(contains('You now rate')));
    expect(md, isNot(contains('Would I do this again')));
    final empty = lookBackMarkdown(
      experience: exp(),
      participants: [],
      checkIns: [],
      now: DateTime(2026, 7, 20),
    );
    expect(empty, contains('No check-ins recorded.'));
  });
}
