import 'package:flutter/material.dart';

import './pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spentall',
      theme: ThemeData(
          canvasColor: Color.fromRGBO(102, 114, 228, 1),
          primaryColor: Color.fromRGBO(247, 249, 252, 1),
          buttonColor: Color.fromRGBO(129, 158, 252, 1),
          backgroundColor: Color.fromRGBO(102, 114, 228, 1),
          accentColor: Color.fromRGBO(255, 185, 246, 1),
          textTheme: TextTheme(
              // bodyText1: TextStyle(color: Color.fromRGBO(247, 249, 252, 1)),
              headline1: TextStyle(
                  color: Color.fromRGBO(255, 185, 246, 1),
                  fontSize: 22,
                  fontWeight: FontWeight.normal))),
      home: TabsPage(),
      routes: {
        // CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(),
      },
      // onUnknownRoute: () {
      // return MaterialPageRoute(builder: (ctx) => CategoriesPage());
      // },
    );
  }
}
