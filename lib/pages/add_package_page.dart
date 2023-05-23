import 'package:curierat_frontend/httpUtils.dart';
import 'package:flutter/material.dart';

import '../classes/contact.dart';
import '../classes/form.dart';
import '../classes/package.dart';

class AddPackagePage extends StatelessWidget {
  const AddPackagePage({Key? key}) : super(key: key);

  static const String routeName = '/addPackage';

  @override
  Widget build(BuildContext context) {
    TextEditingController senderFirstNameController = TextEditingController();
    TextEditingController senderLastNameController = TextEditingController();
    TextEditingController senderEmailController = TextEditingController();
    TextEditingController senderPhoneController = TextEditingController();

    TextEditingController receiverFirstNameController = TextEditingController();
    TextEditingController receiverLastNameController = TextEditingController();
    TextEditingController receiverEmailController = TextEditingController();
    TextEditingController receiverPhoneController = TextEditingController();

    TextEditingController officeController = TextEditingController();
    TextEditingController destintaionController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController categoryController = TextEditingController();

    Widget contactForm(TextEditingController firstName, TextEditingController lastName, TextEditingController email, TextEditingController phone) {
      return Column(
        children: [
          TextField(
            controller: firstName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'First Name',
            ),
          ),
          TextField(
            controller: lastName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Last Name',
            ),
          ),
          TextField(
            controller: phone,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone',
            ),
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ],
      );
    }

    Widget basicField(TextEditingController controller, String label) {
      return Card(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
        ),
      );
    }

    Future<void> _showMyDialog(MyForm form, double price) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pricing'),
            content: Text('Price: $price RON'),
            actions: <Widget>[
              TextButton(
                child: const Text('Add package'),
                onPressed: () {
                  HttpUtils.postWithBody('/packages/add', form.toJson()).then((value) => {
                    if (value == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Package added')))
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error adding package')))
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add package')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text('Sender contact'),
                  subtitle: contactForm(senderFirstNameController, senderLastNameController, senderEmailController, senderPhoneController)
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Receiver contact'),
                  subtitle: contactForm(receiverFirstNameController, receiverLastNameController, receiverEmailController, receiverPhoneController)
                ),
              ),
              basicField(officeController, 'Office'),
              basicField(destintaionController, 'Destination'),
              basicField(weightController, 'Weight'),
              basicField(categoryController, 'Category'),
              FloatingActionButton(
                  onPressed: () {
                    Contact senderContact = Contact(
                        senderFirstNameController.text,
                        senderLastNameController.text,
                        senderEmailController.text,
                        senderPhoneController.text
                    );
                    Contact receiverContact = Contact(
                        receiverFirstNameController.text,
                        receiverLastNameController.text,
                        receiverEmailController.text,
                        receiverPhoneController.text
                    );
                    String office = officeController.text;
                    String destination = destintaionController.text;
                    double weight = double.parse(weightController.text);
                    int category = int.parse(categoryController.text);
                    MyForm form = MyForm(senderContact, receiverContact, office, destination, weight, category);
                    HttpUtils.sendForm(form).then((value) {
                      if (value == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error either no route found or failed to calculate price')));
                      } else {
                        _showMyDialog(form, value);
                      }
                    });
                  },
                  child: const Icon(Icons.add)
              )
            ],
          ),
        ),
      ),
    );
  }
}
