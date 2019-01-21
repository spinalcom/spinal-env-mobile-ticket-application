import 'package:flutter/material.dart';
import 'package:ticketing/Models/Category.dart';
import 'package:ticketing/Models/DefaultSentence.dart';
import 'package:ticketing/pages/declarationTicketPage.dart';
import 'package:ticketing/widgets/sentenceItem.dart';

class SentenceSelectorPage extends StatelessWidget {
  final Future<List<DefaultSentence>> defaultSentences;
  final Category category;
  final String nodeId;

  const SentenceSelectorPage({this.defaultSentences, this.category, this.nodeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DefaultSentence>>(
        future: defaultSentences,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView(
                  children: snapshot.data
                      .map(
                        (sentence) => SentenceItem(
                              sentence.name,
                              (id) {
                                openDeclarationTicket(context, sentence);
                              },
                              sentence.children,
                            ),
                      )
                      .toList());
            }
            return SentenceItem('autre', (id) {
              openDeclarationTicket(context, id);
            }, []);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  openDeclarationTicket(context, sentence) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketDeclarationPage(nodeId: nodeId, category: category, sentences: sentence,),
        ));
  }
}
