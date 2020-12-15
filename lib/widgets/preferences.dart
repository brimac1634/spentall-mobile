import 'package:flutter/material.dart';
import 'package:spentall_mobile/app_theme.dart';
import 'package:flutter/services.dart';

import './custom_raised_button.dart';

import '../models/currency.dart';
import '../constants/currencies.dart';

import '../helpers/extensions.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  static const _cycleOptions = ['monthly', 'weekly', 'daily'];

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _categoryController = TextEditingController();

  Currency _currency = currencies['HKD'];
  int _target = 0;
  String _cycle = 'monthly';
  List<String> _categories = [
    'food',
    'housing',
    'transportation',
    'travel',
    'entertainment',
    'clothing',
    'groceries',
    'utilities',
    'health',
    'education'
  ];

  bool _isLoading = false;

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
      // await Provider.of<Auth>(context, listen: false)
      //     .login(_authData['email'], _authData['password']);
    } catch (err) {
      // print(err);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomAlertDialog(
      //             title: err.toString(),
      //             content:
      //                 'It looks like we\'ve run into a problem. Please try again!',
      //             actions: [
      //               FlatButton(
      //                 child: Text(
      //                   'Okay',
      //                   style: AppTheme.body1,
      //                 ),
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //                 textColor: AppTheme.darkPurple,
      //               ),
      //             ]));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Currency',
                style: Theme.of(context).textTheme.headline2,
              ),
              CustomRaisedButton(
                child: Text(
                  _currency.id,
                  style: Theme.of(context).textTheme.headline2,
                ),
                type: ButtonType.normal,
                onPressed: () {},
                width: 120,
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Spending Cycle',
                        style: Theme.of(context).textTheme.headline2),
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
                                  style: Theme.of(context).textTheme.headline2,
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
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Row(children: [
                Text('${_cycle.capitalize()} Target',
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: TextFormField(
                    cursorColor: AppTheme.darkPurple,
                    style: AppTheme.input,
                    decoration: InputDecoration(
                        labelText: 'Target',
                        labelStyle: AppTheme.label,
                        errorStyle: AppTheme.inputError,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixText: _currency.currencySymbol,
                        prefixStyle: AppTheme.label,
                        suffixText: '.00',
                        suffixStyle: AppTheme.label),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (int.parse(value).isNaN) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _target = int.parse(value);
                    },
                  ),
                ),
              ])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories (${_categories.length} Total)',
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        cursorColor: AppTheme.darkPurple,
                        style: AppTheme.input,
                        decoration: InputDecoration(
                          labelText: 'New Category',
                          labelStyle: AppTheme.label,
                          errorStyle: AppTheme.inputError,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        keyboardType: TextInputType.text,
                        controller: _categoryController,
                        validator: (value) {
                          if (value.length <= 0) {
                            return 'Field is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CustomRaisedButton(
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      type: ButtonType.normal,
                      onPressed: () {
                        setState(() {
                          _categories
                              .add(_categoryController.text.toLowerCase());
                        });
                        _categoryController.clear();
                      },
                      width: 120,
                    ),
                  ],
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
                                  style: Theme.of(context).textTheme.headline2,
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
                              )
                          // CustomRaisedButton(
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         _categories[index].capitalize(),
                          //         style: Theme.of(context).textTheme.headline2,
                          //       ),
                          //       SizedBox(
                          //         width: 8,
                          //       ),
                          //       Icon(
                          //         Icons.close_outlined,
                          //         color: AppTheme.offWhite,
                          //       )
                          //     ],
                          //   ),
                          //   type: ButtonType.normal,
                          //   onPressed: () {
                          //     setState(() {
                          //       _categories.removeAt(index);
                          //     });
                          //   },
                          // ),
                          )
                      .toList(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomRaisedButton(
            child: Text(
              'Submit',
              style: Theme.of(context).textTheme.headline2,
            ),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
