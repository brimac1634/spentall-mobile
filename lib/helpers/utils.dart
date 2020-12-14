import '../models/date_range.dart';

DateRange getCycleDates(String cycle) {
  final now = DateTime.now();

  switch (cycle) {
    case 'daily':
      return DateRange(DateTime(now.year, now.month, now.day, 0, 0, 0, 1),
          DateTime(now.year, now.month, now.day, 23, 59, 59));
    case 'weekly':
      return DateRange(
          now.subtract(Duration(days: now.weekday)),
          DateTime(now.year, now.month, now.day, 23, 59, 59)
              .add(Duration(days: DateTime.daysPerWeek - now.weekday - 1)));
    case 'monthly':
    default:
      return DateRange(DateTime(now.year, now.month, 1),
          DateTime(now.year, now.month + 1, 0, 23, 59, 59));
  }
}

String formatAmount(double amount) {
  if (amount % 1 != 0) {
    return amount.toStringAsFixed(2);
  }
  return amount.toStringAsFixed(0);
}
