import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './search_field.dart';

import '../models/currency.dart';
import '../providers/auth.dart';

import '../constants/currencies.dart';

import '../app_theme.dart';

class CurrencySelector extends StatefulWidget {
  final Function(Currency currency) onCurrencySelect;

  CurrencySelector({@required this.onCurrencySelect});
  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  final List<Currency> _currencies = currencies.values.toList();
  List<Currency> _filteredCurrencies = currencies.values.toList();

  Widget renderChip(Currency cur) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        widget.onCurrencySelect(cur);
      },
      child: Chip(
        label: SizedBox(
          width: 100,
          child: Text(
            '${cur.id}${cur.currencySymbol != null ? '(${cur.currencySymbol})' : ''}',
            style: AppTheme.label2,
            textAlign: TextAlign.center,
          ),
        ),
        padding: const EdgeInsets.all(12),
        elevation: 2.0,
        shadowColor: AppTheme.darkerPurple,
        backgroundColor: AppTheme.lightPurple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCurrencyString = Provider.of<Auth>(context).user.currency;
    final defaultCurrency = currencies[userCurrencyString];

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
            width: max(400, MediaQuery.of(context).size.width * 0.9),
            height: min(500, MediaQuery.of(context).size.height * 0.8),
            decoration: BoxDecoration(
                color: AppTheme.darkPurple,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('Select Currency',
                        style: Theme.of(context).textTheme.headline2),
                  ),
                  SearchField(
                    onSearch: (String search) {
                      setState(() {
                        _filteredCurrencies = _currencies
                            .where((cur) =>
                                cur.id.toLowerCase().contains(search) ||
                                // cur.currencySymbol.contains(search) ||
                                cur.currencyName.toLowerCase().contains(search))
                            .toList();
                      });
                    },
                  ),
                  if (defaultCurrency != null)
                    Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Default:',
                                style: AppTheme.headline2,
                              ),
                              renderChip(defaultCurrency)
                            ])),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 14),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 2),
                        itemBuilder: (_, i) {
                          final cur = _filteredCurrencies[i];
                          return renderChip(cur);
                        },
                        itemCount: _filteredCurrencies.length,
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
