import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/doughnut_chart.dart';
import '../widgets/top_bar.dart';
import '../widgets/filter_bar.dart';

import '../app_theme.dart';
import '../providers/expenses.dart';
import '../helpers/extensions.dart';

class AnalyticsPage extends StatefulWidget {
  final AnimationController animationController;

  AnalyticsPage({@required this.animationController});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
          child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 200),
              child: RefreshIndicator(
                  onRefresh: () async {
                    await _expenseData.getExpenses(
                        queryType: ExpenseQuery.dateRange);
                  },
                  backgroundColor: AppTheme.offWhite,
                  color: AppTheme.darkPurple,
                  child: SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 26),
                            child: Text(
                              'Amount spent per category (% of total)',
                              style: AppTheme.headline3,
                            ),
                          ),
                          Container(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 0.8,
                              child: DoughnutChart(
                                _expenseData.categoryPercentages,
                                arcWidth: (constraints.maxWidth * 0.22).toInt(),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          ..._expenseData.categoryPercentages
                              .map(
                                (item) => ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.category.capitalize(),
                                        style: AppTheme.label2,
                                      ),
                                      Text(
                                        '${(item.percent * 100).floor()}%',
                                        style: AppTheme.label2,
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                  ))))
    ]);
  }
}
