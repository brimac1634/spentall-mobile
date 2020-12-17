import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/expenses.dart';

import './search_field.dart';
import './expandable.dart';
import './scale_icon_button.dart';

import '../helpers/utils.dart' as utils;
import '../app_theme.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  static const _dateFilterFormat = 'd MMM yyyy';
  var _showSearch = false;

  void _deleteSelectedExpenses(Expenses expenses) async {
    try {
      await expenses.deleteExpense(expenses.selectedExpenses.keys.toList());
      expenses.clearSelected();
    } catch (err) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete expenses', style: AppTheme.input),
        backgroundColor: AppTheme.offWhite,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Column(
      children: [
        Expandable(
          expand: _expenseData.selectedExpenses.length < 1,
          child: ListTile(
              contentPadding: EdgeInsets.all(0),
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
        ),
        Expandable(
          expand: _showSearch,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SearchField(
              onSearch: (value) {
                _expenseData.setSearchText(value);
              },
            ),
          ),
        ),
        Expandable(
          expand: _expenseData.selectedExpenses.length >= 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _expenseData.clearSelected();
                  },
                  child: Text(
                    'Cancel',
                    style: AppTheme.label,
                  ),
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _deleteSelectedExpenses(_expenseData);
                  },
                  child: Text(
                    '(${_expenseData.selectedExpenses.length}) Delete',
                    style: AppTheme.headline4,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
