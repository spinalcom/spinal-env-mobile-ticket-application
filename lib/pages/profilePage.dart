import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticketing/Models/User.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';

class ProfilePage extends StatelessWidget {
  final Future<UserProfile> userProfile;

  ProfilePage(this.userProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(title: 'Profile'),
      body: FutureBuilder(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 400,
                ),
                Text(snapshot.data.name),
                Text(snapshot.data.email),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
      ),
    );
  }
}
