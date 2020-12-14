import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/expenses.dart';

import '../widgets/search_field.dart';
import './scale_icon_button.dart';

import '../helpers/utils.dart' as utils;

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
                '\$${utils.formatAmount(_expenseData.rangeFilteredTotal)}',
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                '${DateFormat(_dateFilterFormat).format(_expenseData.filterRange.start)} to ${DateFormat(_dateFilterFormat).format(_expenseData.filterRange.end)}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ScaleIconButton(
                      imageAsset: 'assets/icons/filter.png',
                      onTap: () {},
                    ),
                    ScaleIconButton(
                      imageAsset: _showSearch
                          ? 'assets/icons/searchS.png'
                          : 'assets/icons/search.png',
                      onTap: () {
                        setState(() {
                          _showSearch = !_showSearch;
                        });
                      },
                    )
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
