import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';

import '../models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  User _user;
  String _registrationEmail;

  bool get isLoggedIn {
    return token != null;
  }

  String get token {
    if (_token != null) {
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
      final response = await http.post('$api/auth/register',
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
      final response = await http.post('$api/auth/login',
          body: json.encode({'email': email, 'password': password}),
          headers: {
            'Content-Type': 'application/json',
          });
      final userData = json.decode(response.body) as Map<String, dynamic>;

      handleLogin(userData['user']);
      _token = userData['token'];
      notifyListeners();

      final preferences = await SharedPreferences.getInstance();
      preferences.setString('token', _token);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey('token')) {
      return false;
    }

    _token = preferences.getString('token');

    final response = await http.get('$api/auth', headers: {
      'x-access-token': 'Bearer $_token',
    });

    final userData = json.decode(response.body) as Map<String, dynamic>;
    handleLogin(userData);

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void handleLogin(Map<String, dynamic> data) {
    _user = User(
        name: data['userName'],
        email: data['userEmail'],
        target: int.parse(data['target'].toString()),
        cycle: data['cycle'],
        currency: data['currency'],
        categories: data['categories'].toString().split(','));
  }
}
