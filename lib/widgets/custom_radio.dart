import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;
  final Function onTap;

  CustomRadio(@required this.isSelected, @required this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? Theme.of(context).accentColor
                : Theme.of(context).primaryColor));
  }
}
