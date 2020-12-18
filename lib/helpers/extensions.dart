extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime otherDate) {
    return this.year == otherDate.year &&
        this.month == otherDate.month &&
        this.day == otherDate.day;
  }
}
