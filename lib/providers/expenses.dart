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

  Map<String, Expense> _expenses = {};

  String _searchText = '';
  Map<String, bool> _selectedExpenses = {};

  DateRange _filterRange;

  Expenses(this.token, this.user, this._expenses, this._searchText,
      this._selectedExpenses, this._filterRange);

  // GETTERS

  Map<String, Expense> get expenses {
    return {..._expenses};
  }

  // HOME PAGE GETTERS

  DateRange get cycleDateRange {
    return utils.getCycleDates(user.cycle);
  }

  double get cycleFilteredTotalExpenses {
    final start = cycleDateRange.start;
    final end = cycleDateRange.end;
    return expenses.values.fold(0, (accum, e) {
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

  // LIST VIEW PAGE GETTERS

  DateRange get filterRange {
    return _filterRange;
  }

  Map<String, Expense> get rangeFilteredExpenses {
    if (filterRange == null) return {};

    final start = filterRange.start;
    final end = filterRange.end;

    return {...expenses}..removeWhere((key, e) {
        if (e.timestamp.compareTo(start) >= 0 &&
            e.timestamp.compareTo(end) <= 0) {
          return false;
        }
        return true;
      });
  }

  double get rangeFilteredTotal {
    return rangeFilteredExpenses.values
        .toList()
        .fold(0, (accum, expense) => accum + expense.amount);
  }

  String get searchText {
    return _searchText;
  }

  Map<String, Expense> get filteredExpensesWithSearch {
    // print(rangeFilteredExpenses);
    if (_searchText.length >= 1) {
      return {...rangeFilteredExpenses}.values.toList().where((exp) {
        return exp.amount.toString().contains(_searchText) ||
            exp.type.contains(_searchText) ||
            exp.notes.contains(_searchText);
      }).fold({}, (accum, exp) {
        accum[exp.id] = exp;
        return accum;
      });
    } else {
      return {...rangeFilteredExpenses};
    }
  }

  Map<String, bool> get selectedExpenses {
    return {..._selectedExpenses};
  }

  // SETTERS

  void setTimeFilter(DateRange dates) {
    _filterRange = dates;
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
    final response = await http
        .get('$api/expenditures', headers: {'x-access-token': 'Bearer $token'});
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
  }
}
