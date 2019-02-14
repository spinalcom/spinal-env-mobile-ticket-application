import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String processName;
  final String categories;
  final String processId;
  final Icon icon;
  final onTap;
  const CategoryItem({
    Key key,
    this.processName,
    this.categories,
    this.icon,
    this.onTap,
    this.processId,
  }) : super(key: key);

  getIcon() {
    if (icon == null)
      return Icon(
        Icons.poll,
        size: 64,
        color: Colors.white,
      );
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        processName,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        categories,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.white),
      ),
      leading: getIcon(),
      onTap: () {
        onTap(context, processId);
      },
    );
  }
}
