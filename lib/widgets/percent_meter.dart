import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/circle_meter.dart';

class PercentMeter extends StatefulWidget {
  final int percentage;

  PercentMeter(@required this.percentage);

  @override
  _PercentMeterState createState() => _PercentMeterState();
}

class _PercentMeterState extends State<PercentMeter>
    with SingleTickerProviderStateMixin {
  AnimationController _percentController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _percentController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 100, end: widget.percentage.toDouble())
        .animate(_percentController);
    _percentController.forward();
  }

  @override
  void dispose() {
    _percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _percentController,
      builder: (ctx, _) {
        return CustomPaint(
          foregroundPainter: CircleMeter(
              currentPercent: _animation.value,
              backColor: Theme.of(context).buttonColor,
              foreColor: Theme.of(context).highlightColor),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Text(
                  '${_animation.value.toInt()}%',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Karla',
                      fontSize: 50),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
