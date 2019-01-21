import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  final String _name;

  TicketHeader(this._name);

  @override
  Widget build(BuildContext context) {
    return Text(_name);
  }
}
