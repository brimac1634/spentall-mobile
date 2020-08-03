import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/expenses.dart';

import './pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Expenses()),
        // ChangeNotifierProvider(create: (ctx) => Expenses()),
      ],
      child: MaterialApp(
        title: 'Spentall',
        theme: ThemeData(
            canvasColor: Color.fromRGBO(102, 114, 228, 1),
            primaryColor: Color.fromRGBO(102, 114, 228, 1),
            buttonColor: Color.fromRGBO(129, 158, 252, 1),
            backgroundColor: Color.fromRGBO(247, 249, 252, 1),
            accentColor: Color.fromRGBO(255, 185, 246, 1),
            fontFamily: 'Karla',
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Color.fromRGBO(247, 249, 252, 1)),
              bodyText2: TextStyle(
                  color: Color.fromRGBO(102, 114, 228, 1), fontSize: 14),
              subtitle1: TextStyle(
                  color: Color.fromRGBO(102, 114, 228, 1),
                  fontWeight: FontWeight.w900),
              subtitle2: TextStyle(
                  color: Color.fromRGBO(247, 249, 252, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              headline1: TextStyle(
                  color: Color.fromRGBO(255, 185, 246, 1),
                  fontSize: 22,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.normal),
              headline2: TextStyle(
                  color: Color.fromRGBO(247, 249, 252, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              headline3: TextStyle(
                  color: Color.fromRGBO(102, 114, 228, 1),
                  fontSize: 22,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold),
              headline4: TextStyle(
                  color: Color.fromRGBO(102, 114, 228, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
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
