import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/expense.dart';

class Expenses with ChangeNotifier {
  Map<String, Expense> _expenses = {
    '1': Expense(
        id: '1',
        amount: 30.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1'),
    '2': Expense(
        id: '2',
        amount: 60.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'housing',
        userId: '1'),
    '3': Expense(
        id: '3',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1'),
  };

  Map<String, bool> _selectedExpenses = {};

  List<DateTime> _timeFilter = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
  ];

  Map<String, Expense> get filteredExpenses {
    return {..._expenses};
  }

  double get totalFilteredAmount {
    return filteredExpenses.values
        .toList()
        .fold(0, (accum, expense) => accum + expense.amount);
  }

  List<DateTime> get timeFilter {
    return [..._timeFilter];
  }

  Map<String, bool> get selectedExpenses {
    return {..._selectedExpenses};
  }

  void setTimeFilter(List<DateTime> dates) {
    _timeFilter = dates;
    notifyListeners();
  }

  void toggleSelected(String id) {
    if (_selectedExpenses.containsKey(id)) {
      _selectedExpenses.remove(id);
    } else {
      _selectedExpenses[id] = true;
    }
    notifyListeners();
  }
}
