import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import './search_field.dart';
import './currency_selector.dart';

import '../extensions.dart';

class ExpenseInput extends StatefulWidget {
  @override
  _ExpenseInputState createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  static List<String> _categoryOptions = [
    'food',
    'entertainment',
    'home',
    'pet',
    'education',
    'groceries',
    'sports'
  ];
  List<String> _filteredCategories = _categoryOptions;
  DateTime _selectedDate = DateTime.now();
  String _currency = 'HKD';
  String _category;

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

  void _presentCurrencyPicker() {
    showDialog(
        context: context,
        builder: (context) {
          return CurrencySelector((cur) {
            setState(() {
              _currency = cur;
            });
            Navigator.of(context).pop();
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
                height: 18,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: RaisedButton(
                      child: Text(
                        _currency,
                        style:
                            TextStyle(color: Theme.of(context).backgroundColor),
                      ),
                      onPressed: _presentCurrencyPicker,
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
                height: 18,
              ),
              SearchField(
                onSearch: (String search) {
                  setState(() {
                    _filteredCategories = _categoryOptions
                        .where((cat) =>
                            cat.toLowerCase().contains(search.toLowerCase()))
                        .toList();
                  });
                },
              ),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _filteredCategories
                      .map((cat) => Chip(
                            label: Text(cat),
                            elevation: 3,
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 18,
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
