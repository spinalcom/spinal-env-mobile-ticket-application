import 'package:flutter/material.dart';
import 'package:ticketing/colors.dart';
import 'package:ticketing/config.dart';
import 'package:ticketing/pages/homePage.dart';
import 'package:ticketing/userManager.dart';
import 'package:ticketing/widgets/accentColorOverride.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool _stayConnected = false;
  bool _found = true;

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  _onLogin() async {
    setState(() {
      _email = Text(_emailInputController.text).data;
      _password = Text(_passwordInputController.text).data;
    });

    login(_email, _password).then((user) {
      if (user != null) {
        if (_stayConnected) {
          saveUserProfile(user);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (build) {
          return HomePage();
        }));
      }
      setState(() {
        _found = false;
      });
    });
  }

  _onSingUp() {
    Navigator.pushNamed(
      context,
      '/signUp',
    );
  }

  _onChange(value) {
    setState(() {
      _stayConnected = value;
    });
  }

  _displayErrorUserNotFound() {
    if (!_found)
      return Text('User not found');
    else
      return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSpinalcomSurfaceWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appName,
              style: TextStyle(fontSize: 32),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccentColorOverride(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Addresse E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailInputController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccentColorOverride(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _passwordInputController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text('stay connected'),
                      Checkbox(
                        onChanged: _onChange,
                        value: _stayConnected,
                        activeColor: kSpinalcomAccent,
                      ),
                    ],
                  ),
                ),
                _displayErrorUserNotFound(),
                RaisedButton(
                  onPressed: _onLogin,
                  child: Text("Connection"),
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
                FlatButton(
                  onPressed: _onSingUp,
                  child: Text("Inscription"),
                  textColor: kSpinalcomAccent,
                ),
              ]),
        ],
      ),
    );
  }
}
