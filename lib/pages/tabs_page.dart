import 'package:flutter/material.dart';
import 'package:spentall_mobile/pages/analytics_page.dart';
import 'package:spentall_mobile/pages/home_page.dart';
import 'package:spentall_mobile/pages/list_page.dart';
import 'package:spentall_mobile/pages/settings_page.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Map<String, Object>> _pages = [
    {'page': HomePage(), 'title': 'Home', 'icon': Icons.home},
    {'page': ListPage(), 'title': 'List', 'icon': Icons.list},
    {'page': AnalyticsPage(), 'title': 'Analytics', 'icon': Icons.pie_chart},
    {'page': SettingsPage(), 'title': 'Settings', 'icon': Icons.settings}
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
