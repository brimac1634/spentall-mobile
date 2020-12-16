import 'package:flutter/material.dart';

import './expandable.dart';

import '../app_theme.dart';

class DropDown extends StatefulWidget {
  final bool isOpen;
  final String title;
  final Widget child;

  DropDown({this.isOpen = false, this.title = '', @required this.child});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool _expand;

  @override
  void initState() {
    super.initState();
    setState(() {
      _expand = widget.isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              _expand = !_expand;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.offWhite,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.darkerPurple,
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: ListTile(
              title: Text(
                widget.title,
                style: AppTheme.headline2,
              ),
              trailing: Icon(
                _expand
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down_outlined,
                size: 46,
                color: AppTheme.darkPurple,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Expandable(
            expand: _expand,
            child: widget.child,
          ),
        )
      ],
    );
  }
}
