import 'package:flutter/material.dart';
import 'package:ticketing/ticketManager.dart';

import 'package:ticketing/widgets/bottomNavBar.dart';

class TicketHistory extends StatefulWidget {
  final String userId;

  const TicketHistory({Key key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TicketHistory(fetchTicketHistory(this.userId));
  }
}

class _TicketHistory extends State<TicketHistory> {
  final Future<List<String>> tickets;

  _TicketHistory(this.tickets);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: tickets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0)
              return ListView(
                  children: snapshot.data.map((ticket) => Text(ticket)).toList());
            return Text('Aucun ticket declaré');
          }

          return CircularProgressIndicator();
        },
      ),
        bottomNavigationBar: BottomNavBar()
    );
  }
}