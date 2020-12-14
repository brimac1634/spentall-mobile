import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './analytics_page.dart';
import './home_page.dart';
import './list_page.dart';
import './settings_page.dart';

import '../widgets/expense_input.dart';
import '../widgets/bottom_bar_view.dart';

import '../models/tab_icon_data.dart';
import '../providers/expenses.dart';

import '../app_theme.dart';

class TabsPage extends StatefulWidget {
  static const pathName = '/tabs';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.offWhite,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomePage(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setPageIndex(int index) {
    animationController.reverse().then<dynamic>((data) {
      if (!mounted) {
        return;
      }
      setState(() {
        switch (index) {
          case 0:
            tabBody = HomePage(animationController: animationController);
            break;
          case 1:
            tabBody = ListPage(animationController: animationController);
            break;
          case 2:
            tabBody = AnalyticsPage(animationController: animationController);
            break;
          case 3:
            tabBody = SettingsPage(animationController: animationController);
            break;
          default:
            tabBody = HomePage(animationController: animationController);
        }
      });
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

  Future<bool> _getExpenses() async {
    await Provider.of<Expenses>(context, listen: false).getExpenses();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.darkPurple,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: _getExpenses(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(
              children: <Widget>[
                (snapshot.hasData)
                    ? SafeArea(child: tabBody)
                    : Center(child: CircularProgressIndicator()),
                BottomBarView(
                  tabIconsList: tabIconsList,
                  addClick: () {
                    _showModalBottomSheet(context);
                  },
                  changeIndex: (int index) {
                    _setPageIndex(index);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
