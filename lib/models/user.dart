import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String email;
  final int target;
  final String cycle;
  final String currency;
  final List<String> categories;

  User(
      {@required this.name,
      @required this.email,
      this.target,
      this.cycle,
      this.currency,
      this.categories});
}
