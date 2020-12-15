import 'package:flutter/material.dart';

import '../widgets/preferences.dart';
import '../widgets/top_bar.dart';

import '../app_theme.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [Preferences()],
          ),
        )),
        TopBar(
          topBarOpacity: _animation.value,
          animationController: _animationController,
          title: 'User Preferences',
        )
      ]),
    );
  }
}
