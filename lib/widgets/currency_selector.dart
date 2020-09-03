import 'package:flutter/material.dart';

import './search_field.dart';

import '../constants/currencies.dart';

class CurrencySelector extends StatefulWidget {
  final Function onCurrencySelect;

  CurrencySelector(@required this.onCurrencySelect);
  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  List<String> _filteredCurrencies = currencies.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(30),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Select Currency',
                    style: Theme.of(context).textTheme.headline3),
              ),
              SearchField(
                onSearch: (String search) {
                  setState(() {
                    _filteredCurrencies = currencies.keys
                        .toList()
                        .where((cur) =>
                            cur.toLowerCase().contains(search.toLowerCase()))
                        .toList();
                  });
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2),
                    itemBuilder: (_, i) {
                      return RaisedButton(
                        child: Text(
                          _filteredCurrencies[i],
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor),
                        ),
                        onPressed: () {
                          widget.onCurrencySelect(_filteredCurrencies[i]);
                        },
                      );
                    },
                    itemCount: _filteredCurrencies.length,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
