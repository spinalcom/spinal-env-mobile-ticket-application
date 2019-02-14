import 'package:flutter/material.dart';
import 'package:ticketing/Models/DefaultSentence.dart';
import 'package:ticketing/Models/Process.dart';
import 'package:ticketing/pages/declarationTicketPage.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';
import 'package:ticketing/widgets/sentenceItem.dart';

class SentenceSelectorPage extends StatelessWidget {
  final Future<List<Categories>> defaultSentences;
  final Process category;
  final String nodeId;
  final String roomName;
  final String roomId;
  final String processId;

  const SentenceSelectorPage({
    this.defaultSentences,
    this.category,
    this.nodeId,
    this.roomName,
    this.roomId,
    this.processId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(
          title: roomName,
          leading: Icon(
            Icons.location_on,
            size: 40,
          )),
      body: FutureBuilder<List<Categories>>(
        future: defaultSentences,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView(
                  children: snapshot.data
                      .map((sentence) => Padding(
                            padding: EdgeInsets.all(8),
                            child: SentenceItem(
                              sentence.name,
                              (id) {
                                openDeclarationTicket(context, sentence);
                              },
                              sentence.children,
                            ),
                          ))
                      .toList());
            }
            return SentenceItem('autre', (id) {
              openDeclarationTicket(context, id);
            }, []);
          }
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }

  openDeclarationTicket(context, sentence) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketDeclaration(
              roomName: roomName,
              problemName: sentence.name,
              roomId: roomId,
              processId: processId),
        ));
  }
}
