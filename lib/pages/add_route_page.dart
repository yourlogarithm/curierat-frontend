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
        print(finalDateTime.toIso8601String());
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
              cities = cities.map((element) => element[0].toUpperCase() + element.substring(1)).toList();
              String dateTime = _selectedDate!.toIso8601String();
              String transport = _transportEditingController.text;
              await HttpUtils.post('/routes/add', {
                'cities': cities,
                'start': dateTime,
                'transport': transport,
              });
              Navigator.of(context).pop();
            },
            child: const Text('Add route'),
          )
        ],
      ),
    );
  }
}
