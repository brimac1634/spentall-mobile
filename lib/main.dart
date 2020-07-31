import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/expenses_provider.dart';

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
            primaryColor: Color.fromRGBO(247, 249, 252, 1),
            buttonColor: Color.fromRGBO(129, 158, 252, 1),
            backgroundColor: Color.fromRGBO(102, 114, 228, 1),
            accentColor: Color.fromRGBO(255, 185, 246, 1),
            fontFamily: 'Karla',
            textTheme: TextTheme(
                // bodyText1: TextStyle(color: Color.fromRGBO(247, 249, 252, 1)),
                headline1: TextStyle(
                    color: Color.fromRGBO(255, 185, 246, 1),
                    fontSize: 22,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal))),
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
