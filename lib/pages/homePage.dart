import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:ticketing/pages/categoryChoose.dart';
import 'package:ticketing/ticketManager.dart';
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
        appBar: AppBar(
          title: Center(child: Text('SpinalTicketing')),
        ),
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
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: _scan,
            tooltip: 'Declacerer un ticket',
            child: Icon(
              Icons.photo_camera,
            )),
        bottomNavigationBar: BottomNavBar());
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
          builder: (context) =>
              CategoryChose(categories: fetchCategories(), nodeId: id)),
    );
  }
}
