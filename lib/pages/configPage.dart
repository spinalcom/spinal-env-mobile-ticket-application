import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticketing/IpManager.dart';
import 'package:ticketing/Models/IpConfig.dart';
import 'package:ticketing/widgets/TopBar.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Future<IpConfig> ipConfig = getIpConfig();
  final ticketIpController = TextEditingController();
  final userIpController = TextEditingController();

  _ConfigPageState();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    ticketIpController.dispose();
    userIpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(title: 'Configuration'),
      body: FutureBuilder(
        future: ipConfig,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: ticketIpController,
                    decoration: InputDecoration(
                        labelText: 'address serveur ticket',
                        hintText: snapshot.data.ipTicket),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: userIpController,
                    decoration: InputDecoration(
                        labelText: 'address serveur user',
                        hintText: snapshot.data.ipUser),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    saveIpConfig(IpConfig(
                        ipTicket: ticketIpController.text,
                        ipUser: userIpController.text));
                  },
                  child: Text('Sauvegarder'),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
