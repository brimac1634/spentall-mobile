import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/expenses.dart';
import 'providers/auth.dart';

import './pages/tabs_page.dart';
import './pages/auth_page.dart';

import './app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Expenses()),
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: MaterialApp(
        title: 'Spentall',
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
              labelStyle: TextStyle(
                color: AppTheme.darkPurple,
              ),
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(5))),
              filled: true,
              fillColor: AppTheme.offWhite,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: AppTheme.offWhite, fontSize: 16),
                bodyText2: TextStyle(color: AppTheme.darkPurple, fontSize: 16),
                subtitle1: TextStyle(
                    color: AppTheme.darkPurple, fontWeight: FontWeight.w900),
                subtitle2: TextStyle(
                    color: AppTheme.offWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
                headline1: TextStyle(
                    color: AppTheme.pink,
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal),
                headline2: TextStyle(
                    color: AppTheme.offWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                headline3: TextStyle(
                    color: AppTheme.darkPurple,
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold),
                headline4: TextStyle(
                    color: AppTheme.darkPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ))),
        home: AuthPage(),
        routes: {
          TabsPage.pathName: (ctx) => TabsPage(),
          AuthPage.pathName: (ctx) => AuthPage()
        },
        // onUnknownRoute: () {
        // return MaterialPageRoute(builder: (ctx) => CategoriesPage());
        // },
      ),
    );
  }
}
