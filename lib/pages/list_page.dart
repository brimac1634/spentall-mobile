import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expenses.dart';

import '../widgets/top_bar.dart';
import '../widgets/filter_bar.dart';
import '../widgets/expense_item.dart';

import '../app_theme.dart';

class ListPage extends StatefulWidget {
  final AnimationController animationController;

  ListPage({@required this.animationController});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    final _filteredExpenseList =
        _expenseData.filteredExpensesWithSearch.values.toList();

    final int count = _expenseData.filteredExpensesWithSearch.length > 10
        ? 10
        : _expenseData.filteredExpensesWithSearch.length;
    return Column(
      children: <Widget>[
        TopBar(
          topBarOpacity: 1,
          animationController: widget.animationController,
          child: FilterBar(),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                await _expenseData.getExpenses();
              },
              backgroundColor: AppTheme.offWhite,
              color: AppTheme.darkPurple,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8, bottom: 200),
                itemBuilder: (ctx, i) {
                  final Animation<double> _animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: widget.animationController,
                              curve: Interval((1 / count) * i, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  widget.animationController.forward();

                  return ExpenseItem(
                    animationController: widget.animationController,
                    animation: _animation,
                    expense: _filteredExpenseList[i],
                  );
                },
                itemCount: _filteredExpenseList.length,
              ),
            ),
          ),
        )
      ],
    );
  }
}
