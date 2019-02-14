class Categories {
  final String name;
  List<Categories> children;

  Categories({this.name, children});

  factory Categories.fromJson(js) {
    return Categories(name: js['name']);
  }
}
