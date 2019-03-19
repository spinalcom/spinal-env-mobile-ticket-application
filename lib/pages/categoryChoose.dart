import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticketing/Models/Node.dart';
import 'package:ticketing/Models/Process.dart';
import 'package:ticketing/colors.dart';
import 'package:ticketing/pages/senetenceSelectorPage.dart';
import 'package:ticketing/ticketManager.dart';
import 'package:ticketing/widgets/TopBar.dart';
import 'package:ticketing/widgets/bottomNavBar.dart';
import 'package:ticketing/widgets/categoryItem.dart';

class CategoryPage extends StatelessWidget {
  final Future<Node> node;
  final Future<List<Process>> processes;

  const CategoryPage({Key key, this.node, this.processes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Node>(
      future: node,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: topBar(
                title: snapshot.data.name,
                leading: Icon(
                  Icons.location_on,
                  size: 40,
                )),
            body: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Quel genre de probleme rencontrez-vous ?',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(16, 22, 88, 1.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CategoryItemList(
                        processes: processes,
                        roomName: snapshot.data.name,
                        roomId: snapshot.data.id),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBar(
              selectedIndex: 2,
            ),
          );
        }
        return Scaffold(
          appBar: topBar(
              title: 'Chargement...',
              leading: Icon(
                Icons.location_on,
                size: 40,
              )),
          body: Container(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
              heightFactor: 0.5,
              widthFactor: 0.5,
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: 2,
          ),
        );
      },
    );
  }
}

class CategoryItemList extends StatelessWidget {
  final Future<List<Process>> processes;
  final String roomName;
  final String roomId;

  const CategoryItemList({Key key, this.processes, this.roomName, this.roomId})
      : super(key: key);

  getIcon(iconName) {
    switch (iconName) {
      case 'streetview':
        return Icons.streetview;
      case 'build':
        return Icons.build;
      case 'warning':
        return Icons.warning;
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'accessible':
        return Icons.accessible;
      case 'account_balance':
        return Icons.account_balance;
      case 'alarm':
        return Icons.alarm;
      case 'all_out':
        return Icons.all_out;
      case 'announcement':
        return Icons.announcement;
      case 'bug_report':
        return Icons.bug_report;
      case 'bug_report':
        return Icons.bug_report;
      case 'bookmark':
        return Icons.bookmark;
      case 'book':
        return Icons.book;
      case 'dashboard':
        return Icons.dashboard;
      case 'favorite':
        return Icons.favorite;
      case 'help':
        return Icons.help;
      case 'group_work':
        return Icons.group_work;
      case 'block':
        return Icons.block;
      case 'account_balance':
        return Icons.account_balance;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'spa':
        return Icons.spa;
      case 'kitchen':
        return Icons.kitchen;
      default:
        return Icons.poll;
    }
  }

  getStringFromCategories(process) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Process>>(
      future: processes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0)
            return ListView(
              children: snapshot.data
                  .map(
                    (process) => Padding(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kSpinalcomAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: CategoryItem(
                              icon: Icon(
                                getIcon(process.icon),
                                size: 64,
                                color: Colors.white,
                              ),
                              processName: process.name,
                              categories: process.categoriesString,
                              onTap: openCategoriesSelection,
                              processId: process.id,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                        ),
                  )
                  .toList(),
            );
          return Text('Aucun process de ticket créé');
        }

        return Container(
            child: Column(
          children: <Widget>[
            Text('Chargement des type de problème...'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ));
      },
    );
  }

  openCategoriesSelection(context, processId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SentenceSelectorPage(
              processId: processId,
              defaultSentences: fetchCategories(processId),
              roomName: roomName,
              roomId: roomId),
        ));
  }
}
