class UserProfile {
  String name;
  String firstName;
  String email;
  String password;
  String id;

  UserProfile({this.name, this.firstName, this.email, this.password, this.id});

  factory  UserProfile.fromJson(Map<String, dynamic> js) {
    return UserProfile(
        name: js['name'],
        firstName: js['firstname'],
        email: js['email'],
        password: js['password'],
        id: js['id']);
  }
}