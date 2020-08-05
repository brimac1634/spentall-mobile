import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/expenses.dart';

import '../widgets/search_field.dart';

import '../assets/spent_all_icons.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  static const _dateFilterFormat = 'd MMM yyyy';
  var _showSearch = false;

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Card(
      color: Theme.of(context).backgroundColor,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
              title: Text(
                '\$${_expenseData.totalFilteredAmount}',
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                '${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[0])} to ${DateFormat(_dateFilterFormat).format(_expenseData.timeFilter[1])}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor),
                      child: IconButton(
                        icon: Icon(
                          SpentAllIcons.filter,
                          color: Theme.of(context).canvasColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _showSearch
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).backgroundColor),
                      child: IconButton(
                        icon: Icon(
                          SpentAllIcons.search,
                          color: _showSearch
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).canvasColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _showSearch = !_showSearch;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )),
          if (_showSearch)
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: SearchField(
                onSearch: (value) {
                  // print(value);
                  _expenseData.setSearchText(value);
                },
              ),
            )
        ],
      ),
    );
  }
}
