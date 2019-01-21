import 'package:flutter/material.dart';
import 'package:ticketing/Models/Category.dart';
import 'package:ticketing/color.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final Icon categoryIcon;
  final void Function(Category caterogy) onTap;

  const CategoryItem(
      {Key key,
        this.categoryIcon,
        this.onTap, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          categoryIcon,
          Text(category.name)
        ],
      ),
      onTap: () {
        onTap(category);
      },
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
      splashColor: kSpinalcomBlue300,
    );
  }

}


