import 'package:flutter/foundation.dart';

import '../models/expense.dart';

class Expenses with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses {
    return [..._expenses];
  }
}
