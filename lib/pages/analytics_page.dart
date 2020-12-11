import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  final AnimationController animationController;

  AnalyticsPage({@required this.animationController});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('AnalyticsPage'));
  }
}
