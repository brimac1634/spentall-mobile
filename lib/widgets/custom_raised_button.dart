import 'package:flutter/material.dart';

import '../app_theme.dart';

enum ButtonType { normal, special }

class CustomRaisedButton extends StatelessWidget {
  final double width;
  final ButtonType type;
  final Function onPressed;
  final Widget child;

  CustomRaisedButton(
      {this.width,
      this.type = ButtonType.special,
      @required this.onPressed,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: type == ButtonType.special
              ? AppTheme.linearGradient
              : LinearGradient(
                  colors: [AppTheme.lightPurple, AppTheme.lightPurple]),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkerPurple,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: child,
              ),
            )),
      ),
    );
  }
}
