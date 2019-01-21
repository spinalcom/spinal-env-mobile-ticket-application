import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:ticketing/pages/categoryChoose.dart';
import 'package:ticketing/ticketManager.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String firstname;
  final String email;
  final String password;
  final String id;

  HomePage({this.name, this.firstname, this.password, this.email, this.id})
      : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedId = 0;

  String _qrNodeId = "";
  String _sentence = "";
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
          child: Image(
            image: ExactAssetImage('images/qrcode.png'),
            width: 200,
            height: 200,
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
