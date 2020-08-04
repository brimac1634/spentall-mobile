import 'package:flutter/material.dart';
import 'dart:math';

class CircleMeter extends CustomPainter {
  static const strokeWidth = 22.0;
  final Color backColor;
  final Color foreColor;
  double currentPercent;

  CircleMeter(
      {@required this.currentPercent,
      @required this.backColor,
      @required this.foreColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke;

    Paint meterArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = foreColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - strokeWidth;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentPercent / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, meterArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
