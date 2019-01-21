import 'package:flutter/material.dart';
import 'package:ticketing/pages/SenetenceSelectorPage.dart';
import 'package:ticketing/widgets/categoryItem.dart';
import 'package:ticketing/Models/Category.dart';
import 'package:ticketing/ticketManager.dart';

class CategoryChose extends StatelessWidget {
  final Future<List<Category>> categories;
  final String nodeId;
  const CategoryChose({Key key, this.categories, this.nodeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SpinalTicketing')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0),
        child: FutureBuilder<List<Category>>(
          future: categories,
          builder: (context, snapshot) {
            print('loris');
            if (snapshot.hasData) {

              print(snapshot.data);
              if (snapshot.data.length > 0)
                return GridView(
                  children: snapshot.data
                      .map(
                        (category) => Padding(
                              child: CategoryItem(
                                categoryIcon: Icon(
                                  getIcon(category.icon),
                                  size: 64,
                                ),
                                category: category,
                                onTap: (category) {
                                  openSentenceSelector(context, category);
                                },
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              return Text('Aucun process de ticket créé');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  getIcon(iconName) {
    print(iconName);
    switch (iconName) {
      case 'streetview':
        return Icons.streetview;
      case 'build':
        return Icons.build;
      case 'warning':
        return Icons.warning;
      case 'accessibility_new':
        return Icons.accessibility_new;
      default:
        return Icons.poll;
    }
  }

  openSentenceSelector(context, category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SentenceSelectorPage(
              defaultSentences: fetchDefaultSentence(category.id),
              category: category,
              nodeId: nodeId,
            ),
      ),
    );
  }
}
