import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import './custom_raised_button.dart';

import '../models/date_range.dart';

import '../helpers/extensions.dart';
import '../app_theme.dart';

class Calendar extends StatefulWidget {
  static const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final DateTime startDate;
  final DateTime endDate;
  final bool range;
  final Function(DateTime date) onSelect;

  Calendar(
      {@required this.startDate,
      this.endDate,
      this.range = false,
      @required this.onSelect});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _month = DateTime.now();

  DateTime _selectedDate;
  DateRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _month = widget.startDate;
    _selectedDate = widget.startDate;
  }

  Widget _renderWeeks() {
    final _firstOfMonth = DateTime(_month.year, _month.month, 1);
    var _startOfEachWeek =
        _firstOfMonth.subtract(Duration(days: _firstOfMonth.weekday));
    var _done = false;

    List<Widget> _weeks = [];

    while (!_done) {
      _weeks.add(_renderDays(_startOfEachWeek));

      _startOfEachWeek = _startOfEachWeek.add(Duration(days: 7));

      _done = _startOfEachWeek.month != _firstOfMonth.month;
    }

    return Column(
      children: _weeks,
    );
  }

  Widget _renderDays(DateTime start) {
    DateTime _date = start;

    List<Widget> _days = [];

    for (var i = 0; i < 7; i++) {
      final _currentDate = DateTime.parse(_date.toString());
      _days.add(Expanded(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              _selectedDate = _currentDate;
            });
          },
          child: Container(
            color: _selectedDate.isSameDay(_date)
                ? AppTheme.pink
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              _date.day.toString(),
              style: _date.month == _month.month
                  ? AppTheme.label2
                  : AppTheme.label3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));

      _date = _date.add(Duration(days: 1));
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _days,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        actions: [
          Container(
            width: min(500, MediaQuery.of(context).size.width * 0.95),
            // height: min(400, MediaQuery.of(context).size.height * 0.95),
            decoration: BoxDecoration(
                color: AppTheme.darkPurple,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    DateFormat('MMMM y').format(widget.startDate),
                    style: AppTheme.headline5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Calendar.dayNames
                      .map(
                        (day) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              day,
                              style: AppTheme.headline3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                _renderWeeks(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        child: Text(
                          'Cancel',
                          style: AppTheme.label2,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: AppTheme.darkPurple,
                      ),
                      CustomRaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Confirm',
                            style: AppTheme.label2,
                          ),
                        ),
                        onPressed: () {
                          widget.onSelect(_selectedDate);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ]);
  }
}
