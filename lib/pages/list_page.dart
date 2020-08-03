import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
          color: Theme.of(context).accentColor,
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              '\$${_expenseData.totalFilteredAmount}',
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: Text(
                '${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[0])} to ${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[1])}'),
            trailing: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {},
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 300,
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return ExpenseItem(
                amount: _expenseData.filteredExpenses.values.toList()[i].amount,
                type: _expenseData.filteredExpenses.values.toList()[i].type,
                timestamp:
                    _expenseData.filteredExpenses.values.toList()[i].timestamp,
              );
            },
            itemCount: _expenseData.filteredExpenses.length,
          ),
        )
      ],
    );
  }
}
