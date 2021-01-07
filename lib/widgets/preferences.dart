import 'package:flutter/material.dart';
import 'package:spentall_mobile/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './custom_raised_button.dart';
import './custom_alert_dialog.dart';
import './currency_selector.dart';

import '../models/currency.dart';
import '../providers/auth.dart';

import '../helpers/extensions.dart';

class Preferences extends StatefulWidget {
  final Currency currency;
  final String cycle;
  final int target;
  final List<String> categories;
  final Function onComplete;

  Preferences(
      {@required this.currency,
      @required this.cycle,
      @required this.target,
      @required this.categories,
      this.onComplete});

  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  static const _cycleOptions = ['monthly', 'weekly', 'daily'];

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _categoryController = TextEditingController();

  Currency _currency;
  int _target;
  String _cycle;
  List<String> _categories;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currency = widget.currency;
      _target = widget.target;
      _cycle = widget.cycle;
      _categories = widget.categories;
    });
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
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
      await Provider.of<Auth>(context, listen: false).updatePreferences(
          currency: _currency.id,
          cycle: _cycle,
          target: _target,
          categores: _categories);
      widget.onComplete();
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

  void _addCategory(String category) {
    setState(() {
      _categories.add(category.toLowerCase());
    });
    _categoryController.clear();
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
    return Form(
      key: _formKey,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Currency',
                  style: AppTheme.label2,
                ),
                CustomRaisedButton(
                  child: Text(
                    _currency.id,
                    style: AppTheme.label2,
                  ),
                  type: ButtonType.normal,
                  onPressed: _presentCurrencyPicker,
                  width: 120,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Spending Cycle', style: AppTheme.label2),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _cycleOptions
                              .map(
                                (option) => CustomRaisedButton(
                                  child: Text(
                                    option.capitalize(),
                                    style: AppTheme.label2,
                                  ),
                                  type: option == _cycle
                                      ? ButtonType.special
                                      : ButtonType.normal,
                                  onPressed: () {
                                    setState(() {
                                      _cycle = option;
                                    });
                                  },
                                  width: 120,
                                ),
                              )
                              .toList()),
                    ])),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_cycle.capitalize()} Target',
                          style: AppTheme.label2),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        cursorColor: AppTheme.darkPurple,
                        style: AppTheme.input,
                        decoration: InputDecoration(
                            labelText: 'Target',
                            labelStyle: AppTheme.label,
                            errorStyle: AppTheme.inputError,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixText: _currency.currencySymbol ?? '',
                            prefixStyle: AppTheme.label,
                            suffixText: '.00',
                            suffixStyle: AppTheme.label),
                        keyboardType: TextInputType.number,
                        initialValue: _target.toString(),
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
                          _target = int.parse(value);
                        },
                      ),
                    ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories (${_categories.length} Total)',
                      style: AppTheme.label2),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    cursorColor: AppTheme.darkPurple,
                    style: AppTheme.input,
                    decoration: InputDecoration(
                        labelText: 'Type to add category',
                        labelStyle: AppTheme.label,
                        errorStyle: AppTheme.inputError,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 36,
                            color: _categoryController.text.length >= 1
                                ? AppTheme.darkPurple
                                : Colors.transparent,
                          ),
                          onPressed: () {
                            if (_categoryController.text.length < 1) return;
                            _addCategory(_categoryController.text);
                          },
                        )),
                    keyboardType: TextInputType.text,
                    controller: _categoryController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      _addCategory(_categoryController.text);
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (_) {
                      if (_categories.length < 1) {
                        return 'Add at least one category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    // runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: Iterable<int>.generate(_categories.length)
                        .toList()
                        .map((index) => Chip(
                              label: Text(
                                _categories[index].capitalize(),
                                style: AppTheme.label2,
                              ),
                              backgroundColor: AppTheme.lightPurple,
                              deleteIcon: Icon(
                                Icons.close,
                                color: AppTheme.offWhite,
                              ),
                              padding: const EdgeInsets.all(12),
                              onDeleted: () {
                                setState(() {
                                  _categories.removeAt(index);
                                });
                              },
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
                      style: AppTheme.headline3,
                    ),
                    onPressed: _submit,
                  ),
          ],
        ),
      ),
    );
  }
}
