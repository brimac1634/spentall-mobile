import 'package:flutter/material.dart';
import 'dart:math';

class CircleMeter extends CustomPainter {
  static const strokeWidth = 10;
  final Color backColor;
  final Color foreColor;

  CircleMeter({@required this.backColor, @required this.foreColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke;

    Paint meterCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = foreColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - strokeWidth;

    canvas.drawCircle(center, radius, paint)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
