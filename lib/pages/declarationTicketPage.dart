import 'package:flutter/material.dart';
import 'package:ticketing/ticketManager.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';

class TicketDeclaration extends StatefulWidget {
  final String roomName;
  final String problemName;
  final String processId;
  final String roomId;
  const TicketDeclaration(
      {Key key, this.roomName, this.problemName, this.processId, this.roomId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TicketDeclarationState(roomName, problemName, processId, roomId);
  }
}

class TicketDeclarationState extends State<TicketDeclaration> {
  final String roomName;
  final String problemName;
  final String processId;
  final String roomId;

  String note;
  String problem;

  final noteController = TextEditingController();
  final problemController = TextEditingController();

  TicketDeclarationState(
      this.roomName, this.problemName, this.processId, this.roomId) {}

  @override
  void dispose() {
    noteController.dispose();
    problemController.dispose();
    super.dispose();
  }

  getTextField() {
    if (this.problemName.contains('Autre'))
      return TextField(
        controller: problemController,
        maxLines: 3,
        decoration: InputDecoration(
            labelText: 'Quel est votre problème ?',
            hintText: problemName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            )),
      );
    return Text(
      problemName,
      style: TextStyle(
        fontSize: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(
        title: 'Déclaration',
        subTitle: roomName,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getTextField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TakePhoto(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: noteController,
                maxLines: 10,
                decoration: InputDecoration(
                    labelText: 'Commentaire',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: RaisedButton(
                  onPressed: _onSend,
                  color: Color.fromRGBO(16, 22, 88, 1.0),
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }

  _onSend() {
    setState(() {
      if (noteController.text.isNotEmpty) note = noteController.text;
      if (problemController.text.isNotEmpty)
        problem = problemController.text;
      else
        problem = problemName;
    });
    sendTicket(
        problemName: problem, note: note, processId: processId, id: roomId);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ConfirmationPage();
    }));
  }
}

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: topBar(),
      body: Stack(
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                Image(
                  image: ExactAssetImage('images/qr.png', scale: 0.5),
                ),
                Image(
                  image: ExactAssetImage('images/check.png', scale: 0.3),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Nous avons bien pris en compte votre déclaration.\n"
                        "Vous receverez une notification dès que le problème sera résolu!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(16, 22, 88, 1.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}

class TakePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Avez-vous des photos ?'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(16, 22, 88, 1.0),
                  ),
                ),
                child: Icon(
                  Icons.camera_enhance,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(16, 22, 88, 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(16, 22, 88, 1.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(16, 22, 88, 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
