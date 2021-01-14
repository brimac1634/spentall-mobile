import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './currency_selector.dart';
import './custom_alert_dialog.dart';
import './custom_raised_button.dart';
import './calendar.dart';
import './custom_dialog.dart';
import './expandable.dart';

import '../helpers/extensions.dart';
import '../models/currency.dart';
import '../providers/expenses.dart';
import '../providers/auth.dart';

import '../app_theme.dart';

class ExpenseInput extends StatefulWidget {
  final String id;
  final DateTime date;
  final Currency currency;
  final String category;
  final double amount;
  final String notes;
  final Function(String id) onSuccess;

  ExpenseInput(
      {this.id,
      this.date,
      this.category,
      this.currency,
      this.amount,
      this.notes,
      this.onSuccess});

  @override
  _ExpenseInputState createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _amountController;
  TextEditingController _notesController;
  final ScrollController _scrollController = ScrollController();

  DateTime _date;
  Currency _currency;
  String _category;
  double _amount;
  String _notes;

  bool _isLoading = false;
  bool _categoryIsNull = false;

  @override
  void initState() {
    super.initState();
    final _user = Provider.of<Auth>(context, listen: false).user;
    setState(() {
      _date = widget.date ?? DateTime.now();
      _currency = widget.currency ?? _user.currency;
      _category = widget.category;
      _amount = widget.amount;
      _notes = widget.notes ?? '';
    });
    _amountController = TextEditingController(
        text: _amount != null ? _amount.toStringAsFixed(2) : null);
    _notesController = TextEditingController(text: _notes);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _categoryIsNull = (_category == null);
    });

    if (_category == null) return;

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Expenses>(context, listen: false).addExpense(
          id: widget.id,
          currency: _currency.id,
          category: _category,
          amount: _amount,
          notes: _notes,
          timestamp: _date);

      widget.onSuccess(widget.id);

      if (widget.id != null) {
        Navigator.of(context).pop(true);
      }

      setState(() {
        _amount = null;
        _category = '';
        _notes = '';
      });
      _amountController.clear();
      _notesController.clear();

      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    } catch (err) {
      print(err);
      showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
                  title: 'Uh Oh',
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
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          child: Calendar(
              startDate: _date,
              onSelect: (date) {
                setState(() {
                  _date = date;
                });
                Navigator.of(context).pop();
              }),
        );
      },
    );
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
      key: _formKey,
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
        padding: EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Expenditure',
                    style: AppTheme.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1. Date',
                          style: AppTheme.label2,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 120),
                          child: CustomRaisedButton(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                  _date.isSameDay(DateTime.now())
                                      ? 'Today'
                                      : DateFormat('d MMM yyyy').format(_date),
                                  style: AppTheme.label2),
                            ),
                            type: ButtonType.normal,
                            onPressed: _presentDatePicker,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2. Currency and Amount',
                                style: AppTheme.label2),
                            SizedBox(
                              height: 12,
                            ),
                            Row(children: [
                              CustomRaisedButton(
                                child: Text(
                                  _currency.id,
                                  style: AppTheme.label2,
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
                                  ),
                                  controller: _amountController,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}'))
                                  ],
                                  validator: (value) {
                                    if (value == null || value == '')
                                      return 'Invalid amount';
                                    final val = double.parse(value);
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
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('3. Category', style: AppTheme.label2),
                          Expandable(
                            expand: _categoryIsNull,
                            child: Text('Please choose a category',
                                style: AppTheme.inputError),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            alignment: WrapAlignment.center,
                            children: Iterable<int>.generate(
                                    _auth.user.categories.length)
                                .toList()
                                .map((index) => InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          _category =
                                              _auth.user.categories[index];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: AppTheme.lightPurple,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            gradient: _category ==
                                                    _auth.user.categories[index]
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
                                        child: Text(
                                          _auth.user.categories[index]
                                              .capitalize(),
                                          style: AppTheme.label2,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('4. Notes', style: AppTheme.label2),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          cursorColor: AppTheme.darkPurple,
                          style: AppTheme.input,
                          controller: _notesController,
                          decoration: InputDecoration(
                            labelText: 'Notes',
                            labelStyle: AppTheme.label,
                            errorStyle: AppTheme.inputError,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          maxLines: 2,
                          minLines: 1,
                          onSaved: (value) {
                            _notes = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : CustomRaisedButton(
                          child: Text(
                            'Submit',
                            style: AppTheme.headline3,
                          ),
                          onPressed: _submit,
                        ),
                  SizedBox(
                    height: 18,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
