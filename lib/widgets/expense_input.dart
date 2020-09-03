import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../extensions.dart';

class ExpenseInput extends StatefulWidget {
  @override
  _ExpenseInputState createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    var date = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(date.year - 1, date.month, date.day),
            lastDate: DateTime(date.year + 1, date.month, date.day))
        .then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Expenditure',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: 'Date',
              //   ),
              //   keyboardType: TextInputType.datetime,
              // ),
              RaisedButton(
                child: Text(
                    _selectedDate.isSameDay(DateTime.now())
                        ? 'Today'
                        : DateFormat('d MMM yyyy').format(_selectedDate),
                    style: TextStyle(color: Theme.of(context).backgroundColor)),
                onPressed: () {
                  _presentDatePicker();
                },
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: RaisedButton(
                      child: Text(
                        'HKD',
                        style:
                            TextStyle(color: Theme.of(context).backgroundColor),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      // TODO: update to currency symbol of currency
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          prefixText: '\$',
                          prefixStyle: TextStyle()),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes'),
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
