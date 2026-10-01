import 'package:brain_refresh/core/dates.dart';
import 'package:brain_refresh/core/rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('24 hour lock', () {
    final created = DateTime(2026, 10, 1, 9);
    expect(isLocked(created, DateTime(2026, 10, 2, 8, 59)), isFalse);
    expect(isLocked(created, DateTime(2026, 10, 2, 9)), isTrue);
  });

  test('due logic', () {
    expect(isDue(null, '2026-10-01', '2026-10-01'), isTrue);
    expect(isDue(null, '2026-10-02', '2026-10-01'), isFalse);
    expect(isDue('true', '2026-09-01', '2026-10-01'), isFalse);
  });

  test('addMonths clamps to month end', () {
    expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
    expect(addMonths(DateTime(2026, 11, 15), 3), DateTime(2027, 2, 15));
    expect(ymd(addMonths(DateTime(2026, 10, 1), 1)), '2026-11-01');
  });

  test('confidence choices', () {
    expect(confidenceChoices.first, 50);
    expect(confidenceChoices.last, 99);
    expect(confidenceChoices.length, 11);
  });
}
