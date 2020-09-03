import 'package:flutter/foundation.dart';

class Currency {
  final String currencyName;
  final String currencySymbol;
  final String id;

  Currency(
      {@required this.currencyName, this.currencySymbol, @required this.id});
}
