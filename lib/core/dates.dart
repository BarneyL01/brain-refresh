import 'package:intl/intl.dart';

final _ymd = DateFormat('yyyy-MM-dd');

String ymd(DateTime d) => _ymd.format(d);

DateTime parseYmd(String s) => _ymd.parseStrict(s);

String todayYmd([DateTime? now]) => ymd(now ?? DateTime.now());

String tomorrowYmd([DateTime? now]) {
  final n = now ?? DateTime.now();
  return ymd(DateTime(n.year, n.month, n.day + 1));
}

/// Same day-of-month N months later, clamped to the last day of that month.
DateTime addMonths(DateTime d, int months) {
  final total = d.month - 1 + months;
  final year = d.year + total ~/ 12;
  final month = total % 12 + 1;
  final last = DateTime(year, month + 1, 0).day;
  return DateTime(year, month, d.day > last ? last : d.day);
}

int daysBetween(String fromYmd, String toYmd) =>
    parseYmd(toYmd).difference(parseYmd(fromYmd)).inDays;
