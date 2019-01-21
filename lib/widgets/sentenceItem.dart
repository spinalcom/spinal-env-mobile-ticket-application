import 'package:flutter/material.dart';

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
            getOpenIcon(),
            Expanded(
              child: ListTile(
                title: Text(_sentence),
                onTap: () {
                  _onTap(_sentence);
                },
              ),
            )
          ],
        ),
        getChildren()
      ],
    );
  }

  getOpenIcon() {
    if (children != null && children.length > 0) {
      return IconButton(
        icon: opened
            ? Icon(Icons.keyboard_arrow_down)
            : Icon(Icons.keyboard_arrow_right),
        tooltip: 'open',
        onPressed: () {
          setState(() {
            opened = !opened;
          });
        },
      );
    }
    return Text('');
  }

  getChildren() {
    if (this.children != null && this.opened) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
        child: Column(
            children: children
                .map((child) =>
                SentenceItem(child['name'], _onTap, child['children']))
                .toList()),
      );
    }
    return Text('');
  }
}