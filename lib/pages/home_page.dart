import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/percent_meter.dart';

import '../providers/expenses.dart';
import '../providers/auth.dart';

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
    final expenses = Provider.of<Expenses>(context);
    final auth = Provider.of<Auth>(context);

    return RefreshIndicator(
        onRefresh: () async {
          await expenses.getExpenses();
        },
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                          ),
                          PercentMeter(
                              expenses.cycleTotalTargetPercentage.ceil()),
                          Container(
                            height: 20,
                          ),
                          Text(
                            '${expenses.cycleTotalTargetPercentage.ceil()}% left of your ${auth.user.cycle} limit',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            'or',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            '\$${utils.formatAmount(expenses.cycleFilteredTotalExpenses)} out of \$${auth.user.target}',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
