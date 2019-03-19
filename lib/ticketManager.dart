import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ticketing/Models/DefaultSentence.dart';
import 'package:ticketing/Models/Node.dart';
import 'package:ticketing/Models/Process.dart';
import 'package:ticketing/Models/User.dart';
import 'package:ticketing/config.dart';
import 'package:ticketing/userManager.dart';

Future<List<Process>> fetchProcesses() async {
  List<Process> categories = [];
  final response = await http.get(kProcesses);
  var tmpProcesses = json.decode(response.body);
  for (var i = 0; i < tmpProcesses.length; i++) {
    categories.add(Process.fromJson(tmpProcesses[i]));
  }
  await new Future.delayed(const Duration(seconds: 1));
  return categories;
}

sendTicket(
    {String problemName, String note, String processId, String id}) async {
  var url = kTicket;
  UserProfile user = await getUserProfile();
  final String userId = user.id;
  http.post(url, body: {
    'ticket': jsonEncode({'name': problemName, 'note': note}),
    'processId': processId,
    'roomId': id,
    'userId': userId
  }).then((response) {});
}

Future<List<Categories>> fetchCategories(String processId) async {
  List<Categories> sentences = [];
  final String url = kSentences + "/$processId";
  final response = await http.get(url);
  var tmpSentences = json.decode(response.body);
  for (var i = 0; i < tmpSentences.length; i++) {
    sentences.add(Categories(
        name: tmpSentences[i]['name'], children: tmpSentences[i]['children']));
  }
  sentences.add(Categories(name: 'Autre', children: []));
  return sentences;
}

Future<List<String>> fetchTicketHistory() async {
  UserProfile user = await getUserProfile();
  final String userId = user.id;
  List<String> tickets = [];
  final String url = kTicketUser + '/$userId';
  final response = await http.get(url);
  var tmpTickets = json.decode(response.body);
  for (var i = 0; i < tmpTickets.length; i++) {
    tickets.add(tmpTickets[i]['name']);
  }
  return tickets;
}

Future<Node> fetchNode(String nodeId) async {
  final String url = kTicketNode + "/$nodeId";
  final response = await http.get(url);
  var tmpTickets = json.decode(response.body);
  print(tmpTickets);
  await new Future.delayed(const Duration(seconds: 1));

  return Node.fromJson(tmpTickets);
}
