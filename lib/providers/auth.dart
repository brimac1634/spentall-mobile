import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';

import '../models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  User _user;
  String _registrationEmail;

  bool get isLoggedIn {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
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

      handleLogin(userData['user']);
      _token = userData['token'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void handleLogin(Map<String, dynamic> data) {
    print(data['categories']);
    _user = User(
        name: data['userName'],
        email: data['userEmail'],
        target: int.parse(data['target']),
        cycle: data['cycle'],
        currency: data['currency'],
        categories: data['categories'].toString().split(','));
  }
}
