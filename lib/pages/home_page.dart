import 'package:flutter/material.dart';

import '../models/circle_meter.dart';

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
          CustomPaint(
            foregroundPainter: CircleMeter(
                currentPercent: 10,
                backColor: Theme.of(context).buttonColor,
                foreColor: Theme.of(context).cursorColor),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: Text(
                    '100%',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Karla',
                        fontSize: 50),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
          ),
          Text('11% of your monthly limit'),
          Text('or'),
          Text('\$868 out of \$8,000'),
        ]);
  }
}
