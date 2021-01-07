import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/expense_doughnut_chart.dart';
import '../widgets/top_bar.dart';
import '../widgets/filter_bar.dart';
import '../widgets/expense_bar_chart.dart';

import '../app_theme.dart';
import '../providers/expenses.dart';

class AnalyticsPage extends StatefulWidget {
  final AnimationController animationController;

  AnalyticsPage({@required this.animationController});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController, curve: Curves.fastOutSlowIn));

    widget.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Column(children: <Widget>[
      TopBar(
        topBarOpacity: 1,
        animationController: widget.animationController,
        child: FilterBar(),
      ),
      Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                await _expenseData.getExpenses(
                    queryType: ExpenseQuery.dateRange);
              },
              backgroundColor: AppTheme.offWhite,
              color: AppTheme.darkPurple,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (context, ch) => FadeTransition(
                      opacity: _animation,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 40 * (1.0 - _animation.value), 0.0),
                          child: ch),
                    ),
                    child: (_expenseData.categoryPercentages.length > 0)
                        ? Padding(
                            padding:
                                const EdgeInsets.only(top: 12, bottom: 200),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 26),
                                  child: Text(
                                    'Amount spent per category \n(% of total)',
                                    style: AppTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: ExpenseDoughnutChart(
                                    _expenseData.categoryPercentages,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Divider(
                                    color: AppTheme.offWhite,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 26),
                                  child: Text(
                                    'Total amount spent per day (${_expenseData.user.currency.currencySymbol ?? '\$'})',
                                    style: AppTheme.headline3,
                                  ),
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: ExpenseBarChart(
                                        _expenseData.barData,
                                        _expenseData
                                                .user.currency.currencySymbol ??
                                            '\$')),
                              ],
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.symmetric(vertical: 36.0),
                            child: Text(
                              'You don\'t have any expenses logged for this time frame, so we don\' have any analytics for you.',
                              style: AppTheme.label2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ))))
    ]);
  }
}
