import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  SplashBackground({this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            'assets/images/auth_background.png',
            fit: BoxFit.cover,
          ),
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
        ),
        if (child != null) child
      ],
    );
  }
}
