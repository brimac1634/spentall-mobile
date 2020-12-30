import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/dropdown.dart';
import '../widgets/preferences.dart';
import '../widgets/custom_alert_dialog.dart';

import '../providers/auth.dart';

import '../app_theme.dart';

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

  void _launchURL() async {
    const url = 'https://www.spentall.com/welcome/contact-us';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              title: 'Uh Oh',
              content: 'We were unable to launch an internet browser',
              actions: [
                FlatButton(
                  child: Text(
                    'okay',
                    style: AppTheme.body1,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: AppTheme.darkPurple,
                ),
              ],
            );
          });
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
                    padding: const EdgeInsets.only(
                        top: 16, right: 16, bottom: 32, left: 16),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FlatButton(
                  child: Text(
                    'Contact Us',
                    style: AppTheme.headline3,
                  ),
                  onPressed: _launchURL,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                ),
              ),
              Divider(
                color: AppTheme.offWhite,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FlatButton(
                  child: Text(
                    'Logout',
                    style: AppTheme.headline3,
                  ),
                  onPressed: _auth.logout,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                ),
              ),
              Divider(
                color: AppTheme.offWhite,
                height: 1,
              ),
              if (snapshot.hasData)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 46),
                  child: Text(
                    snapshot.data,
                    style: AppTheme.label2,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
