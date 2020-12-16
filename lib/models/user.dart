import 'package:flutter/foundation.dart';

import './currency.dart';

class User {
  final String name;
  final String email;
  final int target;
  final String cycle;
  final Currency currency;
  final List<String> categories;

  User(
      {@required this.name,
      @required this.email,
      this.target,
      this.cycle,
      this.currency,
      this.categories});
}
