import 'package:flutter/material.dart';
import 'package:ticketing/Models/Category.dart';
import 'package:ticketing/Models/DefaultSentence.dart';
import 'package:ticketing/Models/Node.dart';
import 'package:ticketing/ticketManager.dart';

class TicketDeclarationPage extends StatefulWidget {
  final String nodeId;
  final DefaultSentence sentences;
  final Category category;

  TicketDeclarationPage(
      {this.nodeId, this.sentences, this.category, });

  @override
  State<StatefulWidget> createState() {
    return _TicketDeclarationPageState(
        fetchNode(this.nodeId), this.sentences, this.category,);
  }
}

class _TicketDeclarationPageState extends State<TicketDeclarationPage> {
  final Future<Node> node;
  final DefaultSentence _sentence;
  final Category _category;

  String _message;
  final _messageController = TextEditingController();

  _TicketDeclarationPageState(
      this.node, this._sentence, this._category, );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Node>(
          future: node,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text('Type de ticket'),
                Text(_category.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("Type de probleme"),
                Text(_sentence.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
              keyboardType: TextInputType.text,
              controller: _messageController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                RaisedButton(onPressed: this._onSend, child: Text("Envoyer")),
          )
        ],
      ),
    );
  }

  _onSend() {
    setState(() {
      _message = _messageController.text;
    });
    sendTicket(_sentence, _message,  node, _category);
  }
}

class TicketDeclarationChoose extends StatelessWidget {
  final List<Widget> _ticketTypes;

  TicketDeclarationChoose(this._ticketTypes);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      child: ListView(
        children: _ticketTypes,
      ),
    );
  }
}
