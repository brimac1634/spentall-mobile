import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_raised_button.dart';
import '../widgets/expandable.dart';
import '../widgets/splash_background.dart';
import '../widgets/custom_alert_dialog.dart';

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

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        final registeredEmail = await Provider.of<Auth>(context, listen: false)
            .register(_authData['name'], _authData['email']);
        _showAlertDialog(context, registeredEmail);
      }
    } catch (err) {
      print(err);
      showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
                  title: err.toString(),
                  content:
                      'It looks like we\'ve run into a problem. Please try again!',
                  actions: [
                    FlatButton(
                      child: Text(
                        'Okay',
                        style: AppTheme.body1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: AppTheme.darkPurple,
                    ),
                  ]));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showAlertDialog(BuildContext context, String email) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: 'Confirmation',
            content:
                'We have sent a confirmation email to $email. If you\'re having trouble finding it, be sure to check your spam folder!',
            actions: [
              CustomRaisedButton(
                child: Text(
                  'Okay',
                  style: Theme.of(context).textTheme.headline2,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }).then((_) {
      _switchAuthMode();
    }).catchError((onError) {
      print(onError.toString());
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
        body: Stack(children: [
      SplashBackground(),
      Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                            cursorColor: AppTheme.darkPurple,
                            style: AppTheme.input,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: AppTheme.label,
                                errorStyle: AppTheme.inputError,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon: Icon(Icons.person_outline)),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.length <= 0) {
                                return 'Name cannot be empty!';
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: TextFormField(
                          cursorColor: AppTheme.darkPurple,
                          style: AppTheme.input,
                          decoration: InputDecoration(
                              labelText: 'E-Mail',
                              labelStyle: AppTheme.label,
                              errorStyle: AppTheme.inputError,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: Icon(Icons.email_outlined)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return 'Invalid email';
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
                            cursorColor: AppTheme.darkPurple,
                            style: AppTheme.input,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: AppTheme.label,
                                errorStyle: AppTheme.inputError,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon: Icon(Icons.lock_outline)),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return 'Password must be at least 6 characters';
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
                            _authMode == AuthMode.Login ? 'Login' : 'Register',
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    ]));
  }
}
