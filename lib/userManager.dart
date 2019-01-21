import 'dart:convert';

import 'package:ticketing/Models/User.dart';
import 'package:ticketing/config.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

Future<UserProfile> login(String email, String password) {
  var url = kLoginUrl;
  return http.post(url, body: {"email": email, "password": password}).then(
      (response) async {
    var js = json.decode(response.body);
    if (js['id'] != null) {

      return UserProfile.fromJson(js);
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
  String firtname = prefs.getString('firtname') ?? '';
  String name = prefs.getString('name') ?? '';
  String id = prefs.getString('id') ?? '';

  return UserProfile(
      email: email,
      password: password,
      firstName: firtname,
      name: name,
      id: id);
}

Future<UserProfile> signUp(String name, String firstname, String email, String password) {
  final String url = kSignUpUrl;
  return http.post(url, body: {
    "name": name,
    "fistname": firstname,
    "email": email,
    "password": password
  }).then((response) {
    var js = json.decode(response.body);
    if (js['bad'] == null) {
      saveUserProfile(UserProfile.fromJson(js)).then((res){
        if (res){
          return getUserProfile();
        }
      });
    }
    return null;
  });


}
