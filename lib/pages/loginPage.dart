
import 'package:flutter/material.dart';
import 'package:ticketing/color.dart';
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

   login(_email, _password).then((user){

     if (user != null){
       if (_stayConnected){
         saveUserProfile(user);
       }
       Navigator.pop(context);
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

  _displayErrorUserNotFound(){
    if (!_found)
    return Text('User not found');
    else
      return Text('');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xff2d3d93), const Color(0xff365bab)]),
            image: DecorationImage(
              image: ExactAssetImage('images/logo.png'),
            )),
        child: Form(
          autovalidate: true,
          child: Column(
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
                        activeColor: kSpinalcomOrange,
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
                  textColor: kSpinalcomOrange,
                ),
              ]),
        ),
      ),
    );
  }
}

