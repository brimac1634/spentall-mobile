import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

import '../widgets/dropdown.dart';
import '../widgets/preferences.dart';

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
  Future<String> _getPackageDetails() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return '${packageInfo.appName ?? 'SpentAll'} - Version ${packageInfo.version}';
    } catch (err) {
      print(err.toString());
      return 'Unable to get app details';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return FutureBuilder<String>(
      future: _getPackageDetails(),
      builder: (context, snapshot) => SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 92),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropDown(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  title: 'User Preferences',
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Preferences(
                      target: _auth.user.target,
                      currency: _auth.user.currency,
                      cycle: _auth.user.cycle,
                      categories: _auth.user.categories,
                      onComplete: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('User Preferences Updated!',
                              style: AppTheme.input),
                          backgroundColor: AppTheme.offWhite,
                        ));
                      },
                    ),
                  )),
              Divider(
                color: AppTheme.offWhite,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: FlatButton(
                  child: Text(
                    'Logout',
                    style: AppTheme.headline3,
                  ),
                  onPressed: _auth.logout,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                ),
              ),
              if (snapshot.hasData)
                Text(
                  snapshot.data,
                  style: AppTheme.label2,
                )
            ],
          ),
        ),
      ),
    );
  }
}
