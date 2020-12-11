import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_raised_button.dart';
import '../widgets/expandable.dart';

import '../providers/auth.dart';

import '../app_theme.dart';

enum AuthMode { Register, Login }

class AuthPage extends StatefulWidget {
  static const pathName = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } else {
      await Provider.of<Auth>(context, listen: false)
          .register(_authData['name'], _authData['email']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Text(
                        'SpentAll',
                        style: TextStyle(fontSize: 48, color: AppTheme.pink),
                      ),
                    ),
                    Expandable(
                      expand: _authMode == AuthMode.Register,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.length >= 1) {
                              return 'Name is cannot be empty!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['name'] = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-Mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                    ),
                    Expandable(
                      expand: _authMode == AuthMode.Login,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      CustomRaisedButton(
                        child: Text(
                          _authMode == AuthMode.Login ? 'login' : 'register',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        onPressed: _submit,
                        width: double.infinity,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: FlatButton(
                        child: Text(
                          _authMode == AuthMode.Login
                              ? 'Not registered? register now.'
                              : 'Already registered? login now.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: _switchAuthMode,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ))),
    ));
  }
}
