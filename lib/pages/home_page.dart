import 'package:flutter/material.dart';

import '../widgets/percent_meter.dart';

class HomePage extends StatefulWidget {
  final AnimationController animationController;

  HomePage({@required this.animationController});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
          ),
          PercentMeter(90),
          Container(
            height: 20,
          ),
          Text(
            '11% of your monthly limit',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'or',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '\$868 out of \$8,000',
            style: Theme.of(context).textTheme.headline2,
          ),
        ]);
  }
}
