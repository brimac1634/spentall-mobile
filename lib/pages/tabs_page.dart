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
  AnimationController _animationController;
  bool _isFetching;

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

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HomePage(animationController: _animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setPageIndex(int index) {
    _animationController.reverse().then<dynamic>((data) {
      if (!mounted) {
        return;
      }
      setState(() {
        switch (index) {
          case 0:
            tabBody = HomePage(animationController: _animationController);
            break;
          case 1:
            tabBody = ListPage(animationController: _animationController);
            break;
          case 2:
            tabBody = AnalyticsPage(animationController: _animationController);
            break;
          case 3:
          default:
            tabBody = SettingsPage(animationController: _animationController);
            break;
        }
      });
    });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ExpenseInput(),
            ),
        isScrollControlled: true);
  }

  Future<bool> _getExpenses() async {
    _isFetching = true;
    try {
      await Provider.of<Expenses>(context, listen: false)
          .getExpenses(byCycle: true);
      return true;
    } catch (err) {
      return false;
    } finally {
      _isFetching = false;
    }
  }

  Widget renderBody(bool isFetching, bool hasData, BuildContext context) {
    if (isFetching) return Center(child: CircularProgressIndicator());
    return (hasData)
        ? tabBody
        : Center(
            child: SizedBox(
              height: 200,
              child: Column(children: [
                Text(
                  'OH DEAR!',
                  style: AppTheme.display1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'We were unable to pull your expenses. Please try again later.',
                  style: AppTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          );
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
                renderBody(_isFetching, snapshot.data, context),
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
