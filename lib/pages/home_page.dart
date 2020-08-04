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
          PercentMeter(),
          Text('11% of your monthly limit'),
          Text('or'),
          Text('\$868 out of \$8,000'),
        ]);
  }
}
