import 'package:flutter/material.dart';
import 'package:ticketing/config.dart';

topBar({String title = '', String subTitle = '', Icon leading}) {
  final String mtitle = title.isEmpty ? appName : title;
  final String msubTitle = subTitle.isEmpty ? '' : subTitle;

  getTitle() {
    List<Widget> res = [];
    res.add(Text(
      mtitle,
      style: TextStyle(fontSize: 24),
    ));
    if (subTitle.isNotEmpty)
      res.add(Text(
        msubTitle,
        style: TextStyle(fontSize: 14),
      ));

    if (res.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: res,
      );
    }
    return Text(
      mtitle,
      style: TextStyle(fontSize: 24),
    );
  }

  if (leading == null) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: getTitle(),
      ),
    );
  } else
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: getTitle(),
      ),
      leading: Icon(
        Icons.location_on,
        size: 40,
      ),
    );
}
