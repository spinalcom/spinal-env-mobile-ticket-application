class Process {
  final String name;
  final String icon;
  final String id;
  final String categoriesString;
  final categoriesJs;
  Process({
    this.name,
    this.icon,
    this.id,
    this.categoriesString,
    this.categoriesJs,
  });

  factory Process.fromJson(Map<String, dynamic> json) {
    String categories = "";
    print(json);
    if (json['categories'] != null)
      for (var i = 0; i < json['categories'].length; i++) {
        categories = categories + json['categories'][i]['name'] + ', ';
      }

    return Process(
        name: json['name'],
        icon: json['icon'],
        id: json['id'],
        categoriesString: categories,
        categoriesJs: json['categories']);
  }
}
