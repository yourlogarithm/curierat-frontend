import 'package:flutter/material.dart';

import '../httpUtils.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({Key? key}) : super(key: key);

  static const String routeName = '/add_route';

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  final TextEditingController _citiesEditingController = TextEditingController();
  final TextEditingController _transportEditingController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now(),);
      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _selectedDate = finalDateTime;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add route'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Cities',
            ),
            controller: _citiesEditingController,
          ),
          IconButton(onPressed: () => _selectDate(context), icon: const Icon(Icons.calendar_today)),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Transport',
            ),
            controller: _transportEditingController,
          ),
          ElevatedButton(
            onPressed: () async {
              List<String> cities = _citiesEditingController.text.split(',');
              cities = cities.map((element) => element[0].trim().toUpperCase() + element.substring(1).trim()).toList();
              String dateTime = _selectedDate!.toIso8601String();
              String transport = _transportEditingController.text;
              Map<String, dynamic> body = {
                'cities': cities,
                'start': dateTime,
                'transport': transport,
              };
              await HttpUtils.postWithBody('/routes/add', body).then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value == 200 ? 'Route added' : 'Error'),
                  ),
                )
              );
              Navigator.of(context).pop();
            },
            child: const Text('Add route'),
          )
        ],
      ),
    );
  }
}
