import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './search_field.dart';
import './currency_selector.dart';
import './custom_alert_dialog.dart';
import './custom_raised_button.dart';

import '../helpers/extensions.dart';
import '../models/currency.dart';
import '../providers/expenses.dart';
import '../providers/auth.dart';

import '../constants/currencies.dart';
import '../app_theme.dart';

class ExpenseInput extends StatefulWidget {
  final String id;
  final DateTime date;
  final Currency currency;
  final String category;
  final double amount;
  final String notes;

  ExpenseInput(
      {this.id,
      this.date,
      this.category,
      this.currency,
      this.amount,
      this.notes});

  @override
  _ExpenseInputState createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  DateTime _date;
  Currency _currency;
  String _category;
  double _amount;
  String _notes;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final _user = Provider.of<Auth>(context, listen: false).user;
    setState(() {
      _date = widget.date ?? DateTime.now();
      _currency = widget.currency ?? _user.currency;
      _category = widget.category ?? '';
      _amount = widget.amount ?? 0;
      _notes = widget.notes ?? '';
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      // await Provider.of<Auth>(context, listen: false).updatePreferences(
      //     currency: _currency.id,
      //     cycle: _cycle,
      //     target: _target,
      //     categores: _categories);
    } catch (err) {
      showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
                  title: err.toString(),
                  content:
                      'It looks like we\'ve run into a problem. Please try again!',
                  actions: [
                    FlatButton(
                      child: Text(
                        'Okay',
                        style: AppTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: AppTheme.darkPurple,
                    ),
                  ]));
    }

    setState(() {
      _isLoading = false;
    });
  }

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
        _date = date;
      });
    });
  }

  void _presentCurrencyPicker() {
    showDialog(
        context: context,
        builder: (context) {
          return CurrencySelector(
            onCurrencySelect: (currency) {
              setState(() {
                _currency = currency;
              });
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return Form(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkPurple,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.darkerPurple,
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      CustomRaisedButton(
                        child: Text(
                          _currency.id,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        type: ButtonType.normal,
                        onPressed: _presentCurrencyPicker,
                        width: 120,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Currency and Amount',
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(
                            height: 12,
                          ),
                          Row(children: [
                            CustomRaisedButton(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  _currency.id,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              type: ButtonType.normal,
                              onPressed: _presentCurrencyPicker,
                              width: 120,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: TextFormField(
                                cursorColor: AppTheme.darkPurple,
                                style: AppTheme.input,
                                decoration: InputDecoration(
                                    labelText: 'Amount',
                                    labelStyle: AppTheme.label,
                                    errorStyle: AppTheme.inputError,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    prefixText: _currency.currencySymbol ?? '',
                                    prefixStyle: AppTheme.label,
                                    suffixText: '.00',
                                    suffixStyle: AppTheme.label),
                                keyboardType: TextInputType.number,
                                initialValue: _amount.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  final val = int.parse(value);
                                  if (val.isNaN || val < 1) {
                                    return 'Invalid number';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _amount = double.parse(value);
                                },
                              ),
                            ),
                          ]),
                        ])),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        runSpacing: 12,
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        children:
                            Iterable<int>.generate(_auth.user.categories.length)
                                .toList()
                                .map((index) => Chip(
                                      label: Text(
                                        _auth.user.categories[index]
                                            .capitalize(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                      backgroundColor: AppTheme.lightPurple,
                                      padding: const EdgeInsets.all(12),
                                      elevation: 2,
                                      shadowColor: AppTheme.darkerPurple,
                                    ))
                                .toList(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : CustomRaisedButton(
                        child: Text(
                          'Submit',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onPressed: _submit,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
