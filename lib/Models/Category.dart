class Category {
  final String name;
  final String icon;
  final String id;

  Category({this.name, this.icon, this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], icon: json['icon'], id: json['id']);
  }
}
