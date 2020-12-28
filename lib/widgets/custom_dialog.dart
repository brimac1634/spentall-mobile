import 'package:flutter/material.dart';
import 'dart:math';

import '../app_theme.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;

  CustomDialog({@required this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        actions: [
          Container(
            width: min(500, MediaQuery.of(context).size.width * 0.95),
            // height: min(400, MediaQuery.of(context).size.height * 0.95),
            decoration: BoxDecoration(
                color: AppTheme.darkPurple,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: child,
          )
        ]);
  }
}
