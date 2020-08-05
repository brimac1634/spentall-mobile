import 'package:flutter/material.dart';

import '../widgets/percent_meter.dart';

class HomePage extends StatelessWidget {
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
