import 'contact.dart';

class MyForm {
  final Contact senderContact;
  final Contact receiverContact;
  final String office;
  final String destination;
  final double weight;
  final int category;

  MyForm(this.senderContact, this.receiverContact, this.office, this.destination,
      this.weight, this.category);

  factory MyForm.fromJson(Map<String, dynamic> json) {
    return MyForm(
        Contact.fromJson(json['sender_contact']),
        Contact.fromJson(json['receiver_contact']),
        json['office'],
        json['destination'],
        json['weight'],
        json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
    'sender_contact': senderContact.toJson(),
    'receiver_contact': receiverContact.toJson(),
    'office': office,
    'destination': destination,
    'weight': weight,
    'category': category
  };
}