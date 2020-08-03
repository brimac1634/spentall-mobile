import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;
  final Function onTap;

  CustomRadio({@required this.isSelected, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 2, color: Theme.of(context).primaryColor),
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).accentColor
                  : Theme.of(context).backgroundColor)),
    );
  }
}
