import 'package:brain_refresh/features/stats/stats_calc.dart';
import 'package:flutter_test/flutter_test.dart';

Resolved r(int c, bool o, [DateTime? at]) => Resolved(c, o, at ?? DateTime(2026, 9, 1), null);

void main() {
  test('Brier score: always 50% scores 0.25', () {
    expect(brierScore([r(50, true), r(50, false), r(50, true)]), closeTo(0.25, 1e-9));
  });

  test('Brier score: perfect and worst', () {
    expect(brierScore([r(99, true)]), closeTo(0.0001, 1e-9));
    expect(brierScore([r(90, false)]), closeTo(0.81, 1e-9));
    expect(brierScore([]), isNull);
  });

  test('Brier by calendar month', () {
    final m = brierByMonth([
      r(70, true, DateTime(2026, 8, 5)),
      r(70, false, DateTime(2026, 9, 5)),
    ]);
    expect(m.keys.toList(), [DateTime(2026, 8), DateTime(2026, 9)]);
    expect(m[DateTime(2026, 8)], closeTo(0.09, 1e-9));
    expect(m[DateTime(2026, 9)], closeTo(0.49, 1e-9));
  });

  test('calibration bands', () {
    final bands = calibrationBands([
      for (var i = 0; i < 5; i++) r(70, i < 4),
      r(75, true),
      r(99, true),
    ]);
    expect(bands.map((b) => b.label),
        ['50-59%', '60-69%', '70-79%', '80-89%', '90-99%']);
    final b70 = bands[2];
    expect(b70.count, 6);
    expect(b70.avgConfidence, closeTo(70.8333, 1e-3));
    expect(b70.pctTrue, closeTo(5 / 6 * 100, 1e-9));
    expect(b70.greyedOut, isFalse);
    expect(bands[4].greyedOut, isTrue);
    expect(bands[0].count, 0);
    expect(bands[0].pctTrue, isNull);
  });
}
