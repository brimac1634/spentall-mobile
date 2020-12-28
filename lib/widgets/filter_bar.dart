import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spentall_mobile/models/date_range.dart';

import '../providers/expenses.dart';

import './search_field.dart';
import './expandable.dart';
import './scale_icon_button.dart';
import './custom_alert_dialog.dart';
import './calendar.dart';

import '../helpers/utils.dart' as utils;
import '../app_theme.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  static const _dateFilterFormat = 'd MMM yyyy';
  var _showSearch = false;
  var _isLoading = false;

  void _deleteSelectedExpenses(Expenses expenses) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await expenses.deleteExpense(expenses.selectedExpenses.keys.toList());
      expenses.clearSelected();
    } catch (err) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete expenses', style: AppTheme.input),
        backgroundColor: AppTheme.offWhite,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _presentDatePicker(DateRange filterRange) {
    showDialog(
      context: context,
      builder: (context) {
        return Calendar(
          startDate: filterRange.start,
          endDate: filterRange.end,
          range: true,
          onSelectRange: (dateRange) {
            print(dateRange);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Column(
      children: [
        Expandable(
          axis: Axis.horizontal,
          expand: !_showSearch,
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
                      onTap: () {
                        _presentDatePicker(_expenseData.filterRange);
                      },
                    ),
                    SizedBox(
                      width: 16,
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
          axis: Axis.horizontal,
          axisAlignment: -1.0,
          expand: _showSearch,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SearchField(
              onSearch: (value) {
                _expenseData.setSearchText(value);
              },
              canCancel: true,
              onCancel: () {
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
            ),
          ),
        ),
        Expandable(
          expand: _expenseData.selectedExpenses.length >= 1,
          child: Column(children: [
            Divider(
              color: AppTheme.darkPurple,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      _expenseData.clearSelected();
                    },
                    child: Text(
                      'Cancel',
                      style: AppTheme.cancel,
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  final itemLength =
                                      _expenseData.selectedExpenses.length;
                                  return CustomAlertDialog(
                                    title: 'Are you sure?',
                                    content:
                                        'Delete ${itemLength.toString()} item${itemLength > 1 ? 's' : ''}',
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          'Cancel',
                                          style: AppTheme.body1,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        textColor: AppTheme.lightText,
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Confirm',
                                          style: AppTheme.body1,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        textColor: AppTheme.darkPurple,
                                      ),
                                    ],
                                  );
                                }).then((delete) {
                              if (delete) {
                                _deleteSelectedExpenses(_expenseData);
                              }
                            });
                          },
                          child: Text(
                            '(${_expenseData.selectedExpenses.length}) Delete',
                            style: AppTheme.flatButton,
                          ),
                        )
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
