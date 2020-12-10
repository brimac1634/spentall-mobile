import 'package:flutter/material.dart';

import './analytics_page.dart';
import './home_page.dart';
import './list_page.dart';
import './settings_page.dart';

import '../widgets/expense_input.dart';

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

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ExpenseInput()),
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: _pages.map((tab) {
          return BottomNavigationBarItem(
              icon: Icon(tab['icon']), title: Text(tab['title']));
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          _showModalBottomSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
