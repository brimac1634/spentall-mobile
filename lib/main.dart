import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/expenses.dart';
import 'providers/auth.dart';

import './pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const darkPurple = Color.fromRGBO(102, 114, 228, 1);
  static const lightPurple = Color.fromRGBO(129, 158, 252, 1);
  static const offWhite = Color.fromRGBO(247, 249, 252, 1);
  static const pink = Color.fromRGBO(255, 185, 246, 1);
  static const lightBlue = Color.fromRGBO(196, 240, 255, 1);

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
            canvasColor: darkPurple,
            primaryColor: darkPurple,
            buttonColor: lightPurple,
            backgroundColor: offWhite,
            accentColor: pink,
            cursorColor: darkPurple,
            highlightColor: lightBlue,
            fontFamily: 'Karla',
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: darkPurple,
              ),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: offWhite,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: offWhite),
                bodyText2: TextStyle(color: darkPurple, fontSize: 16),
                subtitle1:
                    TextStyle(color: darkPurple, fontWeight: FontWeight.w900),
                subtitle2: TextStyle(
                    color: offWhite, fontWeight: FontWeight.w500, fontSize: 16),
                headline1: TextStyle(
                    color: pink,
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal),
                headline2: TextStyle(
                    color: offWhite, fontSize: 20, fontWeight: FontWeight.bold),
                headline3: TextStyle(
                    color: darkPurple,
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold),
                headline4: TextStyle(
                    color: darkPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ))),
        home: TabsPage(),
        routes: {
          // CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(),
        },
        // onUnknownRoute: () {
        // return MaterialPageRoute(builder: (ctx) => CategoriesPage());
        // },
      ),
    );
  }
}
