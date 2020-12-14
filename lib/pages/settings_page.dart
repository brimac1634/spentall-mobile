import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../app_theme.dart';
import '../helpers/extensions.dart';

class SettingsPage extends StatefulWidget {
  final AnimationController animationController;

  SettingsPage({@required this.animationController});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${_auth.user.name.capitalize()}\'s Settings',
              style: AppTheme.display1,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: FlatButton(
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.headline2,
                ),
                onPressed: _auth.logout,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
