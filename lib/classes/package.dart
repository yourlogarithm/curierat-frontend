import 'package:curierat_frontend/classes/contact.dart';

import 'form.dart';

class Package extends MyForm {
  final double price;

  Package(Contact senderContact, Contact receiverContact, String office, String destination, double weight, int category, this.price)
      : super(senderContact, receiverContact, office, destination, weight, category);

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

  Map<String, dynamic> toJson() => {
    'sender_contact': senderContact.toJson(),
    'receiver_contact': receiverContact.toJson(),
    'office': office,
    'destination': destination,
    'weight': weight,
    'category': category,
    'price': price
  };
}