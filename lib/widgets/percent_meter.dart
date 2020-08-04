import 'package:flutter/material.dart';

import '../models/circle_meter.dart';

class PercentMeter extends StatelessWidget {
  // AnimationController percentController;
  // Animation animation;

  // @override
  // void initState() {
  //   super.initState();
  //   percentController = AnimationController(
  //       vsync: this, duration: Duration(milliseconds: 2000));
  //   animation = Tween<double>(begin: 0, end: 80).animate(percentController);
  // }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleMeter(
          // currentPercent: animation.value,
          currentPercent: 60,
          backColor: Theme.of(context).buttonColor,
          foreColor: Theme.of(context).cursorColor),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Text(
              // animation.value,
              '60%',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Karla',
                  fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
