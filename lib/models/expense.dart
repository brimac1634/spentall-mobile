import 'package:flutter/foundation.dart';

class Expense {
  final String id;
  final String userId;
  final String currency;
  final String type;
  final String notes;
  final int amount;
  final DateTime timestamp;

  Expense(
      {@required this.id,
      @required this.userId,
      @required this.currency,
      @required this.type,
      this.notes,
      @required this.amount,
      @required this.timestamp});
}
