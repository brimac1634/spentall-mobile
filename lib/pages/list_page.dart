import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expenses.dart';

import '../widgets/filter_bar.dart';
import '../widgets/expense_item.dart';

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
    return Column(
      children: <Widget>[
        FilterBar(),
        if (_expenseData.selectedExpenses.length >= 1)
          Card(
              color: Theme.of(context).backgroundColor,
              elevation: 5,
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${_expenseData.selectedExpenses.length} selected',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Delete',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )),
        Expanded(
          child: Container(
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                final int count =
                    _expenseData.filteredExpensesWithSearch.length > 10
                        ? 10
                        : _expenseData.filteredExpensesWithSearch.length;
                final Animation<double> _animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: widget.animationController,
                        curve: Interval((1 / count) * i, 1.0,
                            curve: Curves.fastOutSlowIn)));
                widget.animationController.forward();

                return ExpenseItem(
                  animationController: widget.animationController,
                  animation: _animation,
                  id: _expenseData.filteredExpensesWithSearch.values
                      .toList()[i]
                      .id,
                  amount: _expenseData.filteredExpensesWithSearch.values
                      .toList()[i]
                      .amount,
                  type: _expenseData.filteredExpensesWithSearch.values
                      .toList()[i]
                      .type,
                  timestamp: _expenseData.filteredExpensesWithSearch.values
                      .toList()[i]
                      .timestamp,
                );
              },
              itemCount: _expenseData.filteredExpensesWithSearch.length,
            ),
          ),
        )
      ],
    );
  }
}
