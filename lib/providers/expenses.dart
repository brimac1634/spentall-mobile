import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../helpers/spentall_api.dart';

import '../models/expense.dart';
import '../models/user.dart';
import '../models/date_range.dart';
import '../models/category_percent.dart';

import '../helpers/custom_exceptions.dart';
import '../helpers/utils.dart' as utils;

enum ExpenseQuery { cycle, dateRange }

enum Sort { amount, category, date }

class Expenses with ChangeNotifier {
  final String token;
  final User user;

  Map<String, Expense> _expenses = {};

  String _searchText = '';
  Map<String, bool> _selectedExpenses = {};

  DateRange _filterRange;
  Sort _sortBy = Sort.date;
  int _sortDirection = -1;

  Expenses(
      this.token,
      this.user,
      this._expenses,
      this._searchText,
      this._selectedExpenses,
      this._filterRange,
      this._sortBy,
      this._sortDirection);

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

  Sort get sortBy {
    return _sortBy;
  }

  int get sortDirection {
    return _sortDirection;
  }

  Map<String, Expense> get rangeFilteredExpenses {
    if (filterRange == null) return {};

    final start = filterRange.start;
    final end = filterRange.end;

    return {...expenses}..removeWhere((key, e) {
        if (e.timestamp.compareTo(start) >= 0 &&
            e.timestamp.compareTo(
                    DateTime(end.year, end.month, end.day, 23, 59, 59, 59)) <=
                0) {
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

  List<Expense> get filteredExpensesWithFiltersAndSorting {
    List<Expense> _expenseList = [...rangeFilteredExpenses.values];
    if (_searchText.length >= 1) {
      _expenseList = _expenseList.where((exp) {
        _searchText.toLowerCase();
        return exp.amount.toString().contains(_searchText) ||
            exp.type.contains(_searchText) ||
            (exp.notes != null &&
                exp.notes.toLowerCase().contains(_searchText));
      }).toList();
    }
    return _expenseList
      ..sort((a, b) {
        switch (sortBy) {
          case Sort.amount:
            return a.amount.compareTo(b.amount) * sortDirection;
          case Sort.category:
            return a.type.compareTo(b.type) * sortDirection;
          case Sort.date:
          default:
            return a.timestamp.compareTo(b.timestamp) * sortDirection;
        }
      });
  }

  Map<String, bool> get selectedExpenses {
    return {..._selectedExpenses};
  }

  // ANALYTICS VIEW PAGE GETTERS

  List<CategoryPercent> get categoryPercentages {
    double _total = 0;
    Map<String, double> _categoryMap =
        filteredExpensesWithFiltersAndSorting.fold({}, (accum, expense) {
      _total += expense.amount;
      if (accum.containsKey(expense.type)) {
        accum[expense.type] += expense.amount;
      } else {
        accum[expense.type] = expense.amount;
      }
      return accum;
    });

    List<CategoryPercent> _categoryPercentages = [];

    _categoryMap.forEach((category, categoryTotal) {
      _categoryPercentages.add(
          CategoryPercent(category, categoryTotal / _total, categoryTotal));
    });

    _categoryPercentages.sort((a, b) => a.total.compareTo(b.total) * -1);

    return _categoryPercentages;
  }

  // SETTERS

  void setTimeFilter(DateRange dates) {
    _filterRange = dates;
    notifyListeners();
  }

  void setSortBy(Sort sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void setSortDirection(int direction) {
    _sortDirection = direction;
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

  void clearSelected() {
    _selectedExpenses.clear();
    notifyListeners();
  }

  // API CALLS

  Future<void> getExpenses(
      {ExpenseQuery queryType = ExpenseQuery.cycle}) async {
    var query = '';

    if (queryType == ExpenseQuery.cycle) {
      final dateRange = utils.getCycleDates(user.cycle);
      query = '?startDate=${dateRange.start}&endDate=${dateRange.end}';
    } else if (filterRange.start != null && filterRange.end != null) {
      query = '?startDate=${filterRange.start}&endDate=${filterRange.end}';
    }

    final response =
        await SpentAllApi().get(endPoint: '/expenditures$query', token: token);
    final expenses = json.decode(response.body) as List<dynamic>;
    Map<String, Expense> _expenseMap = expenses.fold({}, (accum, e) {
      accum[e['expenditure_id'].toString()] = _newExpense(e);
      return accum;
    });

    _expenses = {..._expenses, ..._expenseMap};
    notifyListeners();
  }

  Future<void> addExpense(
      {String id,
      String currency,
      String category,
      double amount,
      String notes,
      DateTime timestamp}) async {
    final response = await SpentAllApi().post(
        endPoint: '/expenditures/add',
        token: token,
        body: json.encode({
          'expenditure_id': id,
          'currency': currency,
          'type': category,
          'amount': amount,
          'notes': notes,
          'timestamp': timestamp.toUtc().toIso8601String()
        }));
    final expense = json.decode(response.body) as Map<String, dynamic>;
    _expenses[expense['expenditure_id'].toString()] = _newExpense(expense);

    notifyListeners();
  }

  Future<void> deleteExpense(List<String> expenseIds) async {
    if (expenseIds.length < 1) return;

    final _existingExpenses =
        expenseIds.map((id) => _expenses.remove(id)).toList();

    notifyListeners();

    try {
      await SpentAllApi().post(
          endPoint: '/expenditures/delete',
          token: token,
          body: json.encode({'expenditureIDs': expenseIds}));
    } catch (err) {
      _existingExpenses.forEach((expense) {
        _expenses[expense.id] = expense;
      });
      throw CustomException('Failed to Delete');
    }
  }

  // HELPERS

  Expense _newExpense(Map<String, dynamic> expenseData) {
    return Expense(
        id: expenseData['expenditure_id'].toString(),
        userId: expenseData['user_id'].toString(),
        currency: expenseData['currency'],
        type: expenseData['type'],
        notes: expenseData['notes'],
        amount: double.parse(expenseData['amount'].toString()) / 100,
        timestamp:
            DateTime.parse(expenseData['timestamp'].toString()).toLocal());
  }
}
