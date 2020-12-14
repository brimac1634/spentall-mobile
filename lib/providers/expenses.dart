import 'dart:math';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../constants/api.dart';

import '../models/expense.dart';
import '../models/user.dart';
import '../models/date_range.dart';

import '../helpers/utils.dart' as utils;

class Expenses with ChangeNotifier {
  final String token;
  final User user;

  Map<String, Expense> _expenses = {
    '1': Expense(
        id: '1',
        amount: 30.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '2': Expense(
        id: '2',
        amount: 60.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'housing',
        userId: '1',
        notes: ''),
    '3': Expense(
        id: '3',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '4': Expense(
        id: '4',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '5': Expense(
        id: '5',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '6': Expense(
        id: '6',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '7': Expense(
        id: '7',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: ''),
    '8': Expense(
        id: '8',
        amount: 18.0,
        currency: 'HKD',
        timestamp:
            DateTime(2020, DateTime.now().month - 1, Random().nextInt(20)),
        type: 'food',
        userId: '1',
        notes: 'cool'),
  };

  String _searchText = '';
  Map<String, bool> _selectedExpenses = {};

  List<DateTime> _timeFilter = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
  ];

  Expenses(this.token, this.user, this._expenses, this._searchText,
      this._selectedExpenses, this._timeFilter);

  // GETTERS

  DateRange get cycleDateRange {
    return utils.getCycleDates(user.cycle);
  }

  Map<String, Expense> get filteredExpenses {
    return {..._expenses};
  }

  double get cycleFilteredTotalExpenses {
    final start = cycleDateRange.start;
    final end = cycleDateRange.end;
    return filteredExpenses.values.fold(0, (accum, e) {
      if (e.timestamp.compareTo(start) >= 0 &&
          e.timestamp.compareTo(end) <= 0) {
        return accum + e.amount;
      }
      return accum;
    });
  }

  double get cycleTotalTargetPercentage {
    return (user.target - cycleFilteredTotalExpenses) * 100 / user.target;
  }

  String get searchText {
    return _searchText;
  }

  Map<String, Expense> get filteredExpensesWithSearch {
    if (_searchText.length >= 1) {
      return {...filteredExpenses}.values.toList().where((exp) {
        return exp.amount.toString().contains(_searchText) ||
            exp.type.contains(_searchText) ||
            exp.notes.contains(_searchText);
      }).fold({}, (accum, exp) {
        accum[exp.id] = exp;
        return accum;
      });
    } else {
      return {...filteredExpenses};
    }
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

  // SETTERS

  void setTimeFilter(List<DateTime> dates) {
    _timeFilter = dates;
    notifyListeners();
  }

  void setSearchText(String text) {
    _searchText = text;
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

  // API CALLS

  Future<void> getExpenses() async {
    try {
      final response = await http.get('$api/expenditures',
          headers: {'x-access-token': 'Bearer $token'});
      final expenses = json.decode(response.body) as List<dynamic>;
      _expenses = expenses.fold({}, (accum, e) {
        accum[e['expenditure_id'].toString()] = Expense(
            id: e['expenditure_id'].toString(),
            userId: e['user_id'].toString(),
            currency: e['currency'],
            type: e['type'],
            notes: e['notes'],
            amount: double.parse(e['amount'].toString()),
            timestamp: DateTime.parse(e['timestamp'].toString()));

        return accum;
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
