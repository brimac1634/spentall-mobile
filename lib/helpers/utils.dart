import 'package:intl/intl.dart';

import '../models/date_range.dart';
import '../models/user.dart';

import './extensions.dart';

DateRange getCycleDates(String cycle) {
  final now = DateTime.now();

  switch (cycle) {
    case 'daily':
    case 'today':
      return DateRange(DateTime(now.year, now.month, now.day, 0, 0, 0, 1),
          DateTime(now.year, now.month, now.day, 23, 59, 59));
    case 'weekly':
    case 'this week':
      final _thisSunday = now.subtract(Duration(days: now.weekday));
      return DateRange(
          DateTime(
              _thisSunday.year, _thisSunday.month, _thisSunday.day, 0, 0, 0, 1),
          DateTime(now.year, now.month, now.day, 23, 59, 59)
              .add(Duration(days: DateTime.daysPerWeek - now.weekday - 1)));
    case 'yearly':
    case 'this year':
      return DateRange(DateTime(now.year, 1, 1),
          DateTime(now.year + 1, 1, 0, 23, 59, 59, 59));
    case 'monthly':
    case 'this month':
    default:
      return DateRange(DateTime(now.year, now.month, 1),
          DateTime(now.year, now.month + 1, 0, 23, 59, 59));
  }
}

String formatDateRange(DateRange dateRange) {
  const _dateFilterFormat = 'd MMM yyyy';
  final _formattedStartDate =
      DateFormat(_dateFilterFormat).format(dateRange.start);
  if (dateRange.start.isSameDay(dateRange.end)) {
    return _formattedStartDate;
  }
  return '$_formattedStartDate to ${DateFormat(_dateFilterFormat).format(dateRange.end)}';
}

String formatAmount(double amount) {
  if (amount % 1 != 0) {
    return amount.toStringAsFixed(2);
  }
  return amount.toStringAsFixed(0);
}

bool userIsComplete(User user) {
  return user != null &&
      user.target != null &&
      user.cycle != null &&
      user.currency != null &&
      user.categories != null;
}
