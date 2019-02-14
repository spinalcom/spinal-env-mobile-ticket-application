import 'package:flutter/material.dart';
import 'package:ticketing/colors.dart';

class SentenceItem extends StatefulWidget {
  final String _sentence;
  final List<dynamic> children;
  final void Function(String sentence) _onTap;

  SentenceItem(this._sentence, this._onTap, this.children);

  @override
  State<StatefulWidget> createState() {
    return SentenceItemState(this._sentence, this._onTap, this.children);
  }
}

class SentenceItemState extends State<SentenceItem> {
  String _sentence;
  List<dynamic> children;
  void Function(String sentence) _onTap;
  bool opened = false;

  SentenceItemState(this._sentence, this._onTap, this.children);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kSpinalcomAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    _sentence,
                    style: TextStyle(color: kSpinalcomSurfaceWhite),
                  ),
                  onTap: () {
                    _onTap(_sentence);
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
