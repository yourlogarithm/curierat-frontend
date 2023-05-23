
class User {
  final String username;
  final String email;
  final String fullname;
  final bool disabled;
  final int accessLevel;

  User(this.username, this.email, this.fullname, this.disabled, this.accessLevel);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['email'],
      json['fullname'],
      json['disabled'],
      json['access_level']
    );
  }
}