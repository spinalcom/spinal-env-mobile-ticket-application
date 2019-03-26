import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing/IpManager.dart';
import 'package:ticketing/Models/User.dart';
import 'package:ticketing/config.dart';

Future<UserProfile> login(String email, String password) async {
  var url = await getUserIp();
  return http.post('$url$kEndLogin',
      body: {"email": email, "password": password}).then((response) async {
    var js = json.decode(response.body);

    if (js['id'] != null) {
      UserProfile user = UserProfile.fromJson(js);
      saveUserProfile(user);
      return user;
    }
    return null;
  });
}

Future<UserProfile> signUp(
    String name, String firstName, String email, String password) async {
  final String baseUrl = await getUserIp();
  final String url = '$baseUrl$kEndSignUp';
  print(url);
  return http.post(url, body: {
    "name": name,
    "fistname": firstName,
    "email": email,
    "password": password
  }).then((response) {
    var js = json.decode(response.body);
    if (js['bad'] == null) {
      saveUserProfile(UserProfile.fromJson(js)).then((res) {
        if (res) {
          return getUserProfile();
        }
      });
    }
    return null;
  });
}

Future<bool> saveUserProfile(UserProfile user) async {
  if (user.id != null) {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('email', user.email);
    prefs.setString('password', user.password);
    prefs.setString('firtname', user.firstName);
    prefs.setString('name', user.name);
    prefs.setString('id', user.id);

    return true;
  }

  return false;
}

Future<UserProfile> getUserProfile() async {
  final prefs = await SharedPreferences.getInstance();

  String email = prefs.getString('email') ?? '';
  String password = prefs.getString('password') ?? '';
  String firstName = prefs.getString('firtname') ?? '';
  String name = prefs.getString('name') ?? '';
  String id = prefs.getString('id') ?? '';

  return UserProfile(
      email: email,
      password: password,
      firstName: firstName,
      name: name,
      id: id);
}
