import 'package:flutter/material.dart';


class BottomNavBarState extends State<BottomNavBar> {
  void Function(int _selectedItem) _onSelectedItem;

  BottomNavBarState();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff365bab),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: IconButton(
                icon: Icon(IconData(0xe55a, fontFamily: 'MaterialIcons'),
                    color: Color(0xfff68204)),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                tooltip: 'Profile',
              )),
          Expanded(
              child: IconButton(
                icon: Icon(IconData(0xe889, fontFamily: 'MaterialIcons'),
                    color: Color(0xfff68204)),
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                tooltip: 'Mes Tickets',
              )),
        ],
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavBarState();
  }
}