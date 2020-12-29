import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'providers/expenses.dart';
import 'providers/auth.dart';

import './pages/tabs_page.dart';
import './pages/auth_page.dart';
import './pages/preferences_page.dart';

import './widgets/custom_alert_dialog.dart';
import './widgets/splash_background.dart';

import './app_theme.dart';
import './helpers/utils.dart' as utils;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  Future<bool> _tryAutoLogin(Auth auth) async {
    try {
      return await auth.tryAutoLogin();
    } catch (err) {
      print(err);
      return false;
    }
  }

  Widget _renderHome(Auth auth) {
    if (auth.isLoggedIn) {
      if (utils.userIsComplete(auth.user)) {
        return TabsPage();
      } else {
        return PreferencesPage();
      }
    } else {
      return FutureBuilder<bool>(
        future: _tryAutoLogin(auth),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? SplashBackground(
                  child: Center(child: CircularProgressIndicator()),
                )
              : AuthPage();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Expenses>(
              update: (ctx, auth, prev) => Expenses(
                    auth.token,
                    auth.user,
                    prev == null ? {} : prev.expenses,
                    prev == null ? '' : prev.searchText,
                    prev == null ? {} : prev.selectedExpenses,
                    prev == null
                        ? utils.getCycleDates(auth.user.cycle)
                        : prev.filterRange,
                    prev == null ? Sort.date : prev.sortBy,
                    prev == null ? -1 : prev.sortDirection,
                  )),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Spentall',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                canvasColor: AppTheme.darkPurple,
                primaryColor: AppTheme.darkPurple,
                buttonColor: AppTheme.lightPurple,
                backgroundColor: AppTheme.offWhite,
                accentColor: AppTheme.pink,
                cursorColor: AppTheme.darkPurple,
                highlightColor: AppTheme.lightBlue,
                hintColor: AppTheme.offWhite,
                fontFamily: 'Karla',
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                  labelStyle: TextStyle(
                    color: AppTheme.darkPurple,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.offWhite,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                textTheme: TextTheme(
                    bodyText1:
                        TextStyle(color: AppTheme.offWhite, fontSize: 16),
                    bodyText2:
                        TextStyle(color: AppTheme.darkPurple, fontSize: 16),
                    subtitle1: TextStyle(
                        color: AppTheme.darkPurple,
                        fontWeight: FontWeight.w900),
                    subtitle2: TextStyle(
                        color: AppTheme.offWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    headline1: TextStyle(
                        color: AppTheme.pink,
                        fontSize: 22,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.normal),
                    headline2: AppTheme.headline2,
                    headline3: AppTheme.headline3,
                    headline4: AppTheme.headline4,
                    button: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ))),
            home: _renderHome(auth),
            routes: {
              TabsPage.pathName: (ctx) => TabsPage(),
              AuthPage.pathName: (ctx) => AuthPage()
            },
            // onUnknownRoute: () {
            // return MaterialPageRoute(builder: (ctx) => CategoriesPage());
            // },
          ),
        ));
  }
}
