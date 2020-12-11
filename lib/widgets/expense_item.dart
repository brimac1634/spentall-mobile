import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spentall_mobile/assets/spent_all_icons.dart';

import '../providers/expenses.dart';

import '../widgets/custom_radio.dart';

class ExpenseItem extends StatelessWidget {
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final String id;
  final double amount;
  final String type;
  final DateTime timestamp;

  ExpenseItem(
      {@required this.animationController,
      @required this.animation,
      @required this.id,
      @required this.amount,
      @required this.type,
      @required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<Expenses>(context);
    return Dismissible(
        onDismissed: (_) {},
        background: Container(
          color: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  'Delete',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).canvasColor,
                      fontSize: 16),
                ),
              ),
              Icon(
                SpentAllIcons.trash,
                color: Theme.of(context).canvasColor,
                size: 24,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        key: ValueKey(id),
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Theme.of(context).buttonColor,
                      ),
                      child: ListTile(
                        leading: Column(
                          children: <Widget>[
                            Expanded(
                              child: CustomRadio(
                                  isSelected: expenseData.selectedExpenses
                                      .containsKey(id),
                                  onTap: () {
                                    expenseData.toggleSelected(id);
                                  }),
                            )
                          ],
                        ),
                        title: Text(
                          '\$$amount',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        subtitle: Text(
                          type,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        trailing: Text(DateFormat('d MMM').format(timestamp),
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ),
                  ),
                ))));
  }
}
