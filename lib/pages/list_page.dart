import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:spentall_mobile/assets/spent_all_icons.dart';

import '../providers/expenses.dart';

import '../widgets/expense_item.dart';

class ListPage extends StatelessWidget {
  static const _dateFilterFormat = 'd MMM yyyy';
  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Column(
      children: <Widget>[
        Card(
          color: Theme.of(context).backgroundColor,
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              '\$${_expenseData.totalFilteredAmount}',
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              '${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[0])} to ${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[1])}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: IconButton(
              icon: Icon(
                SpentAllIcons.filter,
                color: Theme.of(context).canvasColor,
              ),
              onPressed: () {},
            ),
          ),
        ),
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
                return ExpenseItem(
                  id: _expenseData.filteredExpenses.values.toList()[i].id,
                  amount:
                      _expenseData.filteredExpenses.values.toList()[i].amount,
                  type: _expenseData.filteredExpenses.values.toList()[i].type,
                  timestamp: _expenseData.filteredExpenses.values
                      .toList()[i]
                      .timestamp,
                );
              },
              itemCount: _expenseData.filteredExpenses.length,
            ),
          ),
        )
      ],
    );
  }
}
