import 'package:flutter/material.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar(title: 'Settings'),
        body: Center(child: Text('This page will be filled latter')),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: 1,
        ));
  }
}
