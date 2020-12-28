import 'package:flutter/foundation.dart';

import '../helpers/utils.dart' as utils;

class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange(@required this.start, @required this.end);

  bool isWithinRange(DateRange otherRange) {
    return this.start.compareTo(otherRange.start) >= 0 &&
        this.end.compareTo(otherRange.end) <= 0;
  }
}
