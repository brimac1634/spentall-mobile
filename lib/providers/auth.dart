import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/spentall_api.dart';
import '../constants/currencies.dart';
import '../models/user.dart';

class Auth with ChangeNotifier {
  String _token;
  User _user;

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

  String get cycleDescription {
    switch (_user.cycle) {
      case 'daily':
        return 'Today';
      case 'weekly':
        return 'This Week';
      case 'yearly':
        return 'This Year';
      case 'monthly':
      default:
        return 'This Month';
    }
  }

  // API CALLS

  Future<String> register(String name, String email) async {
    final response = await SpentAllApi().post(
      endPoint: '/auth/register',
      body: json.encode({
        'name': name,
        'email': email,
      }),
    );
    final userEmail = json.decode(response.body) as String;
    return userEmail;
  }

  Future<void> login(String email, String password) async {
    final response = await SpentAllApi().post(
        endPoint: '/auth/login',
        body: json.encode({'email': email, 'password': password}));
    final userData = json.decode(response.body) as Map<String, dynamic>;
    handleLogin(userData['user']);
    _token = userData['token'];
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', _token);
  }

  Future<void> fbLogin(String token, String userId) async {
    final response = await SpentAllApi().post(
        endPoint: '/auth/facebook',
        body: json.encode({'accessToken': token, 'userID': userId}));
    final userData = json.decode(response.body) as Map<String, dynamic>;
    handleLogin(userData['user']);
    _token = userData['token'];
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', _token);
  }

  Future<bool> tryAutoLogin() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey('token')) {
      return false;
    }

    final possibleToken = preferences.getString('token');

    final response =
        await SpentAllApi().get(endPoint: '/auth', token: possibleToken);

    final userData = json.decode(response.body) as Map<String, dynamic>;
    handleLogin(userData);

    _token = possibleToken;

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
        currency: currencies[data['currency']],
        categories: data['categories'].toString().split(','));
  }

  Future<void> updatePreferences(
      {String currency,
      String cycle,
      int target,
      List<String> categores}) async {
    final response = await SpentAllApi().post(
        endPoint: '/settings/update-settings',
        body: json.encode({
          'currency': currency,
          'cycle': cycle,
          'target': target,
          'categories': categores.join(',')
        }),
        token: _token);
    final userData = json.decode(response.body) as Map<String, dynamic>;
    handleLogin(userData);
    notifyListeners();
  }
}
