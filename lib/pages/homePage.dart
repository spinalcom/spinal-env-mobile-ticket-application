import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:ticketing/config.dart';
import 'package:ticketing/pages/categoryChoose.dart';
import 'package:ticketing/ticketManager.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String categoryId = "";
  String name = "";
  String firstname = "";
  String email = "";
  String password = "";
  String id = "";

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar(title: appName),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "CECOBRON",
                  textScaleFactor: 2,
                ),
              ),
              Image(
                image: ExactAssetImage('images/building.png'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 16.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: _scan,
                    child: Text('Scan'),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: 3,
        ));
  }

  _scan() {
    Future<String> futureString = new QRCodeReader()
        .setAutoFocusIntervalInMs(200)
        .setForceAutoFocus(true)
        .setTorchEnabled(true)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan();
    futureString.then(_onQrScan);
  }

  _onQrScan(id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryPage(
                  node: fetchNode(id),
                  processes: fetchProcesses(),
                )));
  }
}
