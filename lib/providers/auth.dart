import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';

import '../models/user.dart';

class Auth with ChangeNotifier {
  bool _isLoggedIn = false;
  String _token;
  DateTime _expiryDate;
  User _user;
  String _registrationEmail;

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  User get user {
    return _user;
  }

  String get registrationEmail {
    return _registrationEmail;
  }

  Future<void> register(String name, String email) async {
    try {
      final response = await http.post('$api/register',
          body: json.encode({
            'name': name,
            'email': email,
          }));
      final userEmail = json.decode(response.body) as String;
      _registrationEmail = userEmail;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post('$api/login',
          body: json.encode({'email': email, 'password': password}));
      final userData = json.decode(response.body) as Map<String, dynamic>;
      _user = User(
          name: userData['userName'],
          email: userData['userEmail'],
          target: userData['target'],
          cycle: userData['cycle'],
          currency: userData['currency'],
          categories: userData['cattegories']);
      _isLoggedIn = true;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
