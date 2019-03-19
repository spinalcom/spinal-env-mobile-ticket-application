import 'package:flutter/material.dart';
import 'package:ticketing/colors.dart';
import 'package:ticketing/config.dart';
import 'package:ticketing/pages/homePage.dart';
import 'package:ticketing/pages/loginPage.dart';
import 'package:ticketing/pages/profilePage.dart';
import 'package:ticketing/pages/signUpPage.dart';
import 'package:ticketing/pages/ticketHistory.dart';
import 'package:ticketing/userManager.dart';

final ThemeData _kSpinalcomTheme = _buildSpinalcomTheme();

TextTheme _buildSpinalcomTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Assassin',
        displayColor: kSpinalcomAccent,
        bodyColor: kSpinalcomAccent,
      );
}

ThemeData _buildSpinalcomTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kSpinalcomAccent,
    primaryColor: kSpinalcomBlue100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kSpinalcomBlue100,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: kSpinalcomBackgroundWhite,
    cardColor: kSpinalcomBackgroundWhite,
    textSelectionColor: kSpinalcomBlue100,
    errorColor: kSpinalcomErrorRed,
    textTheme: _buildSpinalcomTextTheme(base.textTheme),
    primaryTextTheme: _buildSpinalcomTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildSpinalcomTextTheme(base.accentTextTheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}

class SpinalTicketingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: _kSpinalcomTheme,
      home: LoginPage(),
      onGenerateRoute: _getRoute,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return _getMaterialPageRoute(settings, LoginPage());
    case '/signUp':
      return _getMaterialPageRoute(settings, SignUpPage());
    case '/profile':
      return _getMaterialPageRoute(settings, ProfilePage(getUserProfile()));
    case '/history':
      return _getMaterialPageRoute(settings, TicketHistory());
    case '/home':
      return _getMaterialPageRoute(settings, HomePage());
  }
  return null;
}

MaterialPageRoute<void> _getMaterialPageRoute(settings, page) {
  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => page,
    fullscreenDialog: true,
  );
}
