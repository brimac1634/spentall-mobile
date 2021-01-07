import 'package:flutter/material.dart';

import '../widgets/preferences.dart';
import '../widgets/top_bar.dart';

import '../app_theme.dart';
import '../constants/currencies.dart';

class PreferencesPage extends StatefulWidget {
  final Preferences preferences;
  final bool canGoBack;

  PreferencesPage(this.preferences, {this.canGoBack = false});

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
                child: widget.preferences)),
        TopBar(
          topBarOpacity: _animation.value,
          animationController: _animationController,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  if (widget.canGoBack)
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: AppTheme.darkPurple,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  Text(
                    'User Preferences',
                    style: AppTheme.headline2,
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
