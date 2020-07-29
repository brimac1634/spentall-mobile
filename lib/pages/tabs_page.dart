import 'package:flutter/material.dart';

import './analytics_page.dart';
import './home_page.dart';
import './list_page.dart';
import './settings_page.dart';

import '../assets/spent_all_icons.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Map<String, Object>> _pages = [
    {'page': HomePage(), 'title': 'Home', 'icon': SpentAllIcons.home},
    {'page': ListPage(), 'title': 'List', 'icon': SpentAllIcons.list},
    {
      'page': AnalyticsPage(),
      'title': 'Analytics',
      'icon': SpentAllIcons.analytics
    },
    {
      'page': SettingsPage(),
      'title': 'Settings',
      'icon': SpentAllIcons.settings
    }
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).backgroundColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: _pages.map((tab) {
          return BottomNavigationBarItem(
              icon: Icon(tab['icon']), title: Text(tab['title']));
        }).toList(),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: new Row(
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: _pages.map((tab) {
      //         return Container(
      //           height: 60,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[Icon(tab['icon']), Text(tab['title'])],
      //           ),
      //         );
      //       }).toList()),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
