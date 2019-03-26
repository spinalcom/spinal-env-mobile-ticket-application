import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing/Models/IpConfig.dart';

Future<bool> saveIpConfig(IpConfig ipConfig) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('ip-ticket', 'http://' + ipConfig.ipTicket);
  prefs.setString('ip-user', 'http://' + ipConfig.ipUser);

  return true;
}

Future<IpConfig> getIpConfig() async {
  final prefs = await SharedPreferences.getInstance();

  String ipTicket = prefs.getString('ip-ticket') ?? '';
  String ipUser = prefs.getString('ip-user') ?? '';

  return IpConfig(ipTicket: ipTicket, ipUser: ipUser);
}

Future<String> getUserIp() async {
  final prefs = await SharedPreferences.getInstance();
  String ipUser = prefs.getString('ip-user') ?? '';
  return ipUser;
}

Future<String> getTicketIp() async {
  final prefs = await SharedPreferences.getInstance();
  String ipTicket = prefs.getString('ip-ticket') ?? '';
  return ipTicket;
}
