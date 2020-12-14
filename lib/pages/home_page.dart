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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
              ),
              PercentMeter(expenses.cycleTotalTargetPercentage.ceil()),
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
    );
  }
}
