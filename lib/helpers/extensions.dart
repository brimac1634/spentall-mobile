import 'package:flutter/material.dart';

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

extension ColorExtension on Color {
  Color darken({int percent = 10}) {
    print(percent);
    if (percent < 1 || percent > 100) return this;
    var f = 1 - percent / 100;
    return Color.fromARGB(this.alpha, (this.red * f).round(),
        (this.green * f).round(), (this.blue * f).round());
  }
}
