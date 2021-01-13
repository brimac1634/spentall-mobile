import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import './preferences_page.dart';

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

  void _launchURL(String url) async {
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
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: AppTheme.offWhite,
                  height: 1,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  leading: Text(
                    'User Preferences',
                    style: AppTheme.headline3,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.offWhite,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreferencesPage(
                                  Preferences(
                                    target: _auth.user.target,
                                    currency: _auth.user.currency,
                                    cycle: _auth.user.cycle,
                                    categories: _auth.user.categories,
                                    onComplete: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'User Preferences Updated!',
                                            style: AppTheme.input),
                                        backgroundColor: AppTheme.offWhite,
                                      ));
                                    },
                                  ),
                                  canGoBack: true,
                                )));
                  },
                ),
                Divider(
                  color: AppTheme.offWhite,
                  height: 1,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  leading: Text(
                    'Contact Us',
                    style: AppTheme.headline3,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.offWhite,
                  ),
                  onTap: () =>
                      _launchURL('https://www.spentall.com/welcome/contact-us'),
                ),
                Divider(
                  color: AppTheme.offWhite,
                  height: 1,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  leading: Text(
                    'Reset Password',
                    style: AppTheme.headline3,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.offWhite,
                  ),
                  onTap: () => _launchURL(
                      'https://www.spentall.com/user/account/new-password'),
                ),
                Divider(
                  color: AppTheme.offWhite,
                  height: 1,
                ),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  leading: Text(
                    'Logout',
                    style: AppTheme.headline3,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.offWhite,
                  ),
                  onTap: _auth.logout,
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
      ),
    );
  }
}
