import 'package:curierat_frontend/httpUtils.dart';
import 'package:flutter/material.dart';

import '../classes/transport.dart';

class AddTransportPage extends StatelessWidget {
  AddTransportPage({Key? key}) : super(key: key);

  static const routeName = '/add_transport';

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _maxWeightController = TextEditingController();
  final TextEditingController _cargoCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add transport')),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Id',
              ),
            ),
            TextField(
              controller: _maxWeightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Max weight',
              ),
            ),
            TextField(
              controller: _cargoCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cargo category',
              ),
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Transport transport = Transport(_idController.text, int.parse(_cargoCategory.text), double.parse(_maxWeightController.text));
          HttpUtils.postWithBody('/transports/add', transport.toJson()).then((statusCode) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(statusCode == 200 ? 'Transport added' : 'Error'),
              ),
            );
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}
