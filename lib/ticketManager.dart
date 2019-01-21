import 'package:http/http.dart' as http;
import 'package:ticketing/Models/Category.dart';
import 'dart:convert';

import 'package:ticketing/Models/DefaultSentence.dart';
import 'package:ticketing/Models/Node.dart';
import 'package:ticketing/config.dart';

Future<List<Category>> fetchCategories() async {
  List<Category> categories = [];
  final response = await http.get(kProcesses);
  var tmpCat = json.decode(response.body);
  print(tmpCat);

  for (var i = 0; i < tmpCat.length; i++) {
    categories.add(Category.fromJson(tmpCat[i]));
  }
  return categories;
}

sendTicket(sentence, message,  id, category){
  var url = kTicket;
  http.post(url, body: {
    'ticket': jsonEncode({'name': sentence, 'note': message}),
    'processId': category,
    'userId': id,
  }).then((response) {});
}


Future<List<DefaultSentence>> fetchDefaultSentence(String processId) async {
  List<DefaultSentence> sentences = [];
  final String url = kSentences + "/$processId";
  final response = await http.get(url);
  var tmpSentences = json.decode(response.body);
  for (var i = 0; i < tmpSentences.length; i++) {
    sentences.add(DefaultSentence(
        name: tmpSentences[i]['name'], children: tmpSentences[i]['children']));
  }
  sentences.add(DefaultSentence(name: 'Autre', children: []));
  return sentences;
}


Future<List<String>> fetchTicketHistory(String userId) async {
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

  return Node.fromJson(tmpTickets);
}
