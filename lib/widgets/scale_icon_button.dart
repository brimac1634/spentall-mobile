import 'package:flutter/material.dart';

class ScaleIconButton extends StatefulWidget {
  final String imageAsset;
  final Function onTap;

  ScaleIconButton({@required this.imageAsset, @required this.onTap});
  @override
  _ScaleIconButtonState createState() => _ScaleIconButtonState();
}

class _ScaleIconButtonState extends State<ScaleIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: Tween<double>(begin: 0.88, end: 1.0).animate(CurvedAnimation(
          curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn),
          parent: _animationController)),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          _animationController.forward();
          widget.onTap();
        },
        child: Image.asset(
          widget.imageAsset,
          height: 26,
          width: 26,
        ),
      ),
    );
  }
}
