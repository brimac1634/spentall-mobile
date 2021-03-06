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
import './custom_dialog.dart';

import '../helpers/utils.dart' as utils;
import '../helpers/extensions.dart';
import '../app_theme.dart';

class FilterBar extends StatefulWidget {
  @override
  _FilterBarState createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  static const _quickTimeFilters = [
    'today',
    'this week',
    'this month',
    'this year'
  ];

  var _showSearch = false;
  var _isLoading = false;

  var _isLoadingDateChange = false;

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

  Future<void> _updateTimeFilter(Expenses expenses, DateRange dateRange) async {
    if (dateRange.isWithinRange(expenses.cycleDateRange)) {
      expenses.setTimeFilter(dateRange);
    } else {
      setState(() {
        _isLoadingDateChange = true;
      });

      try {
        expenses.setTimeFilter(dateRange);
        await expenses.getExpenses(queryType: ExpenseQuery.dateRange);
      } catch (err) {
        print(err);
      } finally {
        setState(() {
          _isLoadingDateChange = false;
        });
      }
    }
  }

  void _presentSorters() {
    showDialog(
      context: context,
      builder: (context) {
        final _expenses = Provider.of<Expenses>(context);
        return CustomDialog(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Sorting',
                style: AppTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 12,
                  children: Sort.values
                      .map((sort) => InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (_expenses.sortBy == sort) {
                                _expenses.setSortDirection(
                                    _expenses.sortDirection * -1);
                              } else {
                                _expenses.setSortBy(sort);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppTheme.lightPurple,
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: _expenses.sortBy == sort
                                      ? AppTheme.linearGradient
                                      : LinearGradient(colors: [
                                          AppTheme.lightPurple,
                                          AppTheme.lightPurple
                                        ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.darkerPurple,
                                      offset: Offset(0.0, 1.5),
                                      blurRadius: 1.5,
                                    ),
                                  ]),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      sort
                                          .toString()
                                          .split('.')
                                          .last
                                          .capitalize(),
                                      style: AppTheme.label2,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.sort_outlined,
                                      color: AppTheme.offWhite,
                                    ),
                                    if (_expenses.sortBy == sort)
                                      Icon(
                                        _expenses.sortDirection < 0
                                            ? Icons.arrow_downward_outlined
                                            : Icons.arrow_upward_outlined,
                                        color: AppTheme.offWhite,
                                      ),
                                  ]),
                            ),
                          ))
                      .toList()),
            ),
          ]),
        ));
      },
    );
  }

  Future<void> _presentDatePicker(Expenses expenses) async {
    try {
      final _dateRange = await showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            child: Stack(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Time Filter',
                      style: AppTheme.headline5,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: _quickTimeFilters
                        .map((filter) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  final dateRange = utils.getCycleDates(filter);
                                  Navigator.of(context).pop(dateRange);
                                },
                                child: Chip(
                                    backgroundColor: AppTheme.lightPurple,
                                    label: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12),
                                      child: Text(filter.capitalize(),
                                          style: AppTheme.label2),
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                  Calendar(
                    startDate: expenses.filterRange.start,
                    endDate: expenses.filterRange.end,
                    range: true,
                    onSelectRange: (dateRange) {
                      Navigator.of(context).pop(dateRange);
                    },
                  ),
                ]),
              ),
              if (_isLoadingDateChange)
                Center(child: CircularProgressIndicator())
            ]),
          );
        },
      );
      if (_dateRange == null) return;

      setState(() {
        _isLoadingDateChange = true;
      });

      await _updateTimeFilter(expenses, _dateRange);
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoadingDateChange = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _expenseData = Provider.of<Expenses>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expandable(
          alwaysRenderChild: false,
          axis: Axis.horizontal,
          expand: !_showSearch,
          child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                '\$${utils.formatAmount(_expenseData.rangeFilteredTotal)}',
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(
                utils.formatDateRange(_expenseData.filterRange),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ScaleIconButton(
                      imageAsset: 'assets/icons/sort.png',
                      onTap: _presentSorters,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    _isLoadingDateChange
                        ? SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.darkPurple),
                            ),
                          )
                        : ScaleIconButton(
                            imageAsset: 'assets/icons/calendar.png',
                            onTap: () {
                              _presentDatePicker(_expenseData);
                            },
                          ),
                    SizedBox(
                      width: 12,
                    ),
                    ScaleIconButton(
                      imageAsset: 'assets/icons/search.png',
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
          alwaysRenderChild: false,
          axis: Axis.horizontal,
          axisAlignment: -1.0,
          expand: _showSearch,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 9),
            child: SearchField(
              autoFocus: true,
              onSearch: (value) {
                _expenseData.setSearchText(value);
              },
              canCancel: true,
              onCancel: () {
                _expenseData.setSearchText('');
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
            ),
          ),
        ),
        Expandable(
          expand: _expenseData.selectedExpenses.length >= 1,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Divider(
              color: AppTheme.darkPurple,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 2),
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
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.darkPurple),
                          ),
                        )
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
