import 'package:flutter/material.dart';

import '../app_theme.dart';

class TopBar extends StatefulWidget {
  final double topBarOpacity;
  final AnimationController animationController;
  final Widget child;

  TopBar({
    @required this.topBarOpacity,
    @required this.animationController,
    this.child,
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          AppTheme.offWhite.withOpacity(widget.topBarOpacity),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.darkerPurple
                                .withOpacity(0.4 * widget.topBarOpacity),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16 - 8.0 * widget.topBarOpacity,
                                bottom: 12 - 8.0 * widget.topBarOpacity),
                            child: widget.child)
                      ],
                    ),
                  )),
            );
          },
        )
      ],
    );
  }
}
