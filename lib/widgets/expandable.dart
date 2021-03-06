import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  final Widget child;
  final bool expand;
  final Axis axis;
  final double axisAlignment;
  final bool alwaysRenderChild;

  Expandable(
      {this.expand = false,
      @required this.child,
      this.axis = Axis.vertical,
      this.axisAlignment = 1.0,
      this.alwaysRenderChild = true});

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  AnimationController _expandController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );

    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (widget.expand) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(Expandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: widget.axis,
        axisAlignment: widget.axisAlignment,
        sizeFactor: _animation,
        child: (widget.expand || widget.alwaysRenderChild)
            ? widget.child
            : Container());
  }
}
