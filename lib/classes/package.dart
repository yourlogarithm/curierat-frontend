import 'package:curierat_frontend/classes/contact.dart';

class Package {
  final Contact senderContact;
  final Contact receiverContact;
  final String office;
  final String destination;
  final double weight;
  final int category;
  final double price;

  Package(this.senderContact, this.receiverContact, this.office, this.destination, this.weight, this.category, this.price);

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      Contact.fromJson(json['sender_contact']),
      Contact.fromJson(json['receiver_contact']),
      json['office'],
      json['destination'],
      json['weight'],
      json['category'],
      json['price']
    );
  }
}