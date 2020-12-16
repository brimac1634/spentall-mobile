import 'dart:math';

import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  CustomAlertDialog(
      {@required this.title, @required this.content, @required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        actions: [
          Center(
            child: Container(
              width: max(290, MediaQuery.of(context).size.width * 0.8),
              padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppTheme.offWhite,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTheme.headline2,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Text(content, style: AppTheme.label)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: actions.length >= 2
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}
