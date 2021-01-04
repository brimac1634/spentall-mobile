import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/percent_meter.dart';
import '../widgets/top_bar.dart';

import '../providers/expenses.dart';
import '../providers/auth.dart';

import '../app_theme.dart';

import '../helpers/utils.dart' as utils;
import '../helpers/extensions.dart';

class HomePage extends StatefulWidget {
  final AnimationController animationController;

  HomePage({@required this.animationController});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
    final _expenses = Provider.of<Expenses>(context);
    final _auth = Provider.of<Auth>(context);

    return Column(children: [
      TopBar(
        topBarOpacity: 1,
        animationController: widget.animationController,
        child: Container(
          width: double.infinity,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${_auth.cycleDescription}',
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: Text(
              utils.formatDateRange(_expenses.cycleDateRange),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            await _expenses.getExpenses();
          },
          backgroundColor: AppTheme.offWhite,
          color: AppTheme.darkPurple,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: AnimatedBuilder(
                animation: widget.animationController,
                builder: (context, _) => FadeTransition(
                  opacity: _animation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 40 * (1.0 - _animation.value), 0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          PercentMeter(
                              _expenses.cycleTotalTargetPercentage.ceil()),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${_expenses.cycleTotalTargetPercentage.ceil()}%',
                                  style: AppTheme.headline3,
                                ),
                                Text(
                                  ' left of your ${_auth.user.cycle} limit',
                                  style: AppTheme.label2,
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'after spending',
                              style: AppTheme.label2,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${utils.formatAmount(_expenses.cycleFilteredTotalExpenses)}',
                                  style: AppTheme.headline3,
                                ),
                                Text(
                                  ' out of ',
                                  style: AppTheme.label2,
                                ),
                                Text(
                                  '\$${_auth.user.target}',
                                  style: AppTheme.headline3,
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(
                              color: AppTheme.offWhite,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Category Most Spent',
                                  style: AppTheme.label2,
                                ),
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: AppTheme.pink,
                                )
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _expenses.categoryMostSpent.capitalize(),
                            style: AppTheme.display1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(
                              color: AppTheme.offWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    ]);
  }
}
