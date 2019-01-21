class Node {
  String name;
  String id;

  Node({this.name, this.id});

  factory  Node.fromJson(Map<String, dynamic> js) {
    return Node(
        name: js['name'],
        id: js['id']);
  }
}