import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/percent_meter.dart';

import '../providers/expenses.dart';
import '../providers/auth.dart';

import '../app_theme.dart';

import '../helpers/utils.dart' as utils;

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
    final auth = Provider.of<Auth>(context);

    return RefreshIndicator(
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
                  child: SafeArea(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 36,
                            ),
                            PercentMeter(
                                _expenses.cycleTotalTargetPercentage.ceil()),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${_expenses.cycleTotalTargetPercentage.ceil()}% left of your ${auth.user.cycle} limit',
                              style: AppTheme.headline3,
                            ),
                            Text(
                              'or',
                              style: AppTheme.headline3,
                            ),
                            Text(
                              '\$${utils.formatAmount(_expenses.cycleFilteredTotalExpenses)} out of \$${auth.user.target}',
                              style: AppTheme.headline3,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            )));
  }
}
