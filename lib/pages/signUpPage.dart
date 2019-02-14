import 'package:flutter/material.dart';
import 'package:ticketing/colors.dart';
import 'package:ticketing/userManager.dart';
import 'package:ticketing/widgets/accentColorOverride.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String nameInputController = "";
  String firstNameInputController = "";
  String emailInputController = "";
  String passwordInputController = "";
  String passwordConfirmationInputController = "";
  final _nameInputController = TextEditingController();
  final _firstNameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _passwordConfirmationInputController = TextEditingController();

  _onSignUp() {
    setState(() {
      nameInputController = Text(_nameInputController.text).data;
      firstNameInputController = Text(_firstNameInputController.text).data;
      emailInputController = Text(_emailInputController.text).data;
      passwordInputController = Text(_passwordInputController.text).data;
      passwordConfirmationInputController =
          Text(_passwordConfirmationInputController.text).data;
    });
    signUp(nameInputController, firstNameInputController, emailInputController,
            passwordInputController)
        .then((onValue) {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSpinalcomSurfaceWhite,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AccentColorOverride(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'champ requis';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Nom',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _nameInputController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AccentColorOverride(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _firstNameInputController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AccentColorOverride(
                child: TextFormField(
                  validator: (value) {
                    if (!value.contains('@')) {
                      return 'E-mail non valide';
                    }
                    if (value.isEmpty) {
                      return 'champs requis';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Adresse E-mail',
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'champs requis';
                    }
                  },
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
              child: RaisedButton(
                  onPressed: _onSignUp, child: Text("Inscription")),
            ),
          ]),
        ),
      ),
    );
  }
}
