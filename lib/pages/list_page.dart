import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _hasVibrator = false;

  @override
  void initState() {
    super.initState();
    _checkForVibrator();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkForVibrator() async {
    if (await Vibration.hasVibrator()) {
      setState(() {
        _hasVibrator = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    final _expenseLength =
        _expenseData.filteredExpensesWithFiltersAndSorting.length;
    if (_expenseLength < 1) {
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
                child: _expenseLength >= 1
                    ? Scrollbar(
                        controller: _scrollController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 100),
                          itemBuilder: (ctx, i) {
                            final double _begin = 0.1 * i > 1 ? 1.0 : 0.1 * i;
                            final Animation<double> _animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: widget.animationController,
                                        curve: Interval(_begin, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            widget.animationController.forward();

                            return ExpenseItem(
                              animationController: widget.animationController,
                              animation: _animation,
                              expense: _expenseData
                                  .filteredExpensesWithFiltersAndSorting[i],
                              hasVibrator: _hasVibrator,
                            );
                          },
                          itemCount: _expenseData
                              .filteredExpensesWithFiltersAndSorting.length,
                        ),
                      )
                    : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(
                              vertical: 36.0, horizontal: 12),
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
