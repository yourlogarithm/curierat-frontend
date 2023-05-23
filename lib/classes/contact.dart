class Contact {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  Contact(this.firstName, this.lastName, this.email, this.phone);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      json['first_name'],
      json['last_name'],
      json['email'],
      json['phone']
    );
  }
}