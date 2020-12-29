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
    final int count =
        _expenseData.filteredExpensesWithFiltersAndSorting.length > 10
            ? 10
            : _expenseData.filteredExpensesWithFiltersAndSorting.length;
    if (count < 1) {
      widget.animationController.forward();
    }
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
                  await _expenseData.getExpenses(
                      queryType: ExpenseQuery.dateRange);
                },
                backgroundColor: AppTheme.offWhite,
                color: AppTheme.darkPurple,
                child: count >= 1
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 200),
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
                            expense: _expenseData
                                .filteredExpensesWithFiltersAndSorting[i],
                          );
                        },
                        itemCount: _expenseData
                            .filteredExpensesWithFiltersAndSorting.length,
                      )
                    : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(vertical: 36.0),
                          child: Text(
                            'You don\'t have any expenses logged for this time frame, so we don\' have any analytics for you.',
                            style: AppTheme.label2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
          ),
        )
      ],
    );
  }
}
