import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spentall_mobile/assets/spent_all_icons.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

import '../providers/expenses.dart';

import './custom_radio.dart';
import './expense_input.dart';
import './custom_alert_dialog.dart';

import '../app_theme.dart';
import '../models/expense.dart';
import '../helpers/utils.dart' as utils;
import '../constants/currencies.dart';

class ExpenseItem extends StatelessWidget {
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final Expense expense;
  final bool hasVibrator;

  ExpenseItem(
      {@required this.animationController,
      @required this.animation,
      @required this.expense,
      this.hasVibrator = false});

  void _showModalBottomSheet(BuildContext ctx) async {
    try {
      final _didSpend = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: ctx,
          builder: (context) => ExpenseInput(
                id: expense.id,
                amount: expense.amount,
                category: expense.type,
                currency: currencies[expense.currency],
                date: expense.timestamp,
                notes: expense.notes,
              ),
          isScrollControlled: true);

      if (!_didSpend) return;

      Timer(Duration(milliseconds: 600), () {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expenditure Updated!', style: AppTheme.label2),
                Icon(Icons.attach_money)
              ]),
          elevation: 10,
          backgroundColor: AppTheme.lightPurple,
        ));
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Dismissible(
        confirmDismiss: (_) {
          return showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  title: 'Are you sure?',
                  content:
                      'Delete ${currencies[expense.currency].currencySymbol}${utils.formatAmount(expense.amount)} for ${expense.type}',
                  actions: [
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: AppTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: AppTheme.lightText,
                    ),
                    FlatButton(
                      child: Text(
                        'Confirm',
                        style: AppTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: AppTheme.darkPurple,
                    ),
                  ],
                );
              });
        },
        onDismissed: (_) {
          _expenseData.deleteExpense([expense.id]);
        },
        background: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              gradient: AppTheme.linearGradientReversed),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  'Delete',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkPurple,
                      fontSize: 16),
                ),
              ),
              Icon(
                SpentAllIcons.trash,
                color: AppTheme.darkPurple,
                size: 24,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(vertical: 2),
        ),
        direction: DismissDirection.endToStart,
        key: ValueKey(expense.id),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, ch) => FadeTransition(
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: ch)),
          child: Card(
            shadowColor: AppTheme.darkerPurple,
            margin: EdgeInsets.symmetric(vertical: 1),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                onLongPress: () {
                  if (hasVibrator) {
                    Vibration.vibrate(duration: 200);
                  }
                  _showModalBottomSheet(context);
                },
                leading: Column(
                  children: <Widget>[
                    Expanded(
                      child: CustomRadio(
                          isSelected: _expenseData.selectedExpenses
                              .containsKey(expense.id),
                          onTap: () {
                            _expenseData.toggleSelected(expense.id);
                          }),
                    )
                  ],
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '\$${utils.formatAmount(expense.amount)}',
                        style: AppTheme.headline3,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        expense.notes ?? '',
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
                trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(DateFormat('d MMM').format(expense.timestamp),
                          style: Theme.of(context).textTheme.subtitle2),
                      Text(
                        expense.type,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
