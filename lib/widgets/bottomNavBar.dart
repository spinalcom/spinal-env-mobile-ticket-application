import 'package:flutter/material.dart';
import 'package:ticketing/colors.dart';
import 'package:ticketing/pages/homePage.dart';
import 'package:ticketing/pages/profilePage.dart';
import 'package:ticketing/pages/settingsPage.dart';
import 'package:ticketing/pages/ticketHistory.dart';
import 'package:ticketing/userManager.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    Key key,
    this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kSpinalcomBlue100,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromRGBO(16, 22, 88, 1.0),
            ),
            title: Text('Profile',
                style: TextStyle(
                  color: Color.fromRGBO(16, 22, 88, 1.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Color.fromRGBO(16, 22, 88, 1.0),
            ),
            title: Text('Paramètre',
                style: TextStyle(
                  color: Color.fromRGBO(16, 22, 88, 1.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_enhance,
              color: Color.fromRGBO(16, 22, 88, 1.0),
            ),
            title: Text('Scan',
                style: TextStyle(
                  color: Color.fromRGBO(16, 22, 88, 1.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_alert,
              color: Color.fromRGBO(16, 22, 88, 1.0),
            ),
            title: Text('Suivi',
                style: TextStyle(
                  color: Color.fromRGBO(16, 22, 88, 1.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Color.fromRGBO(16, 22, 88, 1.0),
            ),
            title: Text(
              'Historique',
              style: TextStyle(
                color: Color.fromRGBO(16, 22, 88, 1.0),
              ),
            ),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          onItemSelected(index, context);
        },
      ),
    );
  }

  onItemSelected(int index, context) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (build) {
          return ProfilePage(getUserProfile());
        }));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (build) {
          return SettingsPage();
        }));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (build) {
          return HomePage();
        }));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (build) {
          return TicketHistory();
        }));
        break;
      default:
        print(index);
        break;
    }
  }
}
