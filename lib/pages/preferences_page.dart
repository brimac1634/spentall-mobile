import 'package:flutter/material.dart';

import '../widgets/preferences.dart';
import '../widgets/top_bar.dart';

import '../app_theme.dart';
import '../constants/currencies.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 82),
                child: Preferences(
                  currency: currencies['HKD'],
                  cycle: 'monthly',
                  target: 0,
                  categories: [
                    'food',
                    'housing',
                    'transportation',
                    'travel',
                    'entertainment',
                    'clothing',
                    'groceries',
                    'utilities',
                    'health',
                    'education'
                  ],
                ))),
        TopBar(
          topBarOpacity: _animation.value,
          animationController: _animationController,
          title: 'User Preferences',
        )
      ]),
    );
  }
}
