import 'package:curierat_frontend/classes/my_route.dart';
import 'package:curierat_frontend/httpUtils.dart';
import 'package:flutter/material.dart';

import '../classes/package.dart';

class RoutePage extends StatefulWidget {
  const RoutePage(this.route, {Key? key}) : super(key: key);

  final MyRoute route;

  static const routeName = '/route';

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.route.id),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Transport'),
              subtitle: Text(widget.route.transport),
            ),
          ),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.route.cities[index]),
                  trailing: Text(widget.route.schedule[index].toString()),
                );
              },
              itemCount: widget.route.cities.length,
            )
          ),
          Card(
            child: ListTile(
              title: Text('Current weight: ${widget.route.currentWeight}'),
              subtitle: Row(
                children: [
                  const Text('Current position:'),
                  Slider(
                    onChanged: (value) {},
                    max: widget.route.schedule.length.toDouble() - 1,
                    label: widget.route.currentPosition.toString(),
                    value: widget.route.currentPosition.toDouble(),
                    divisions: widget.route.schedule.length-1,
                  )
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  HttpUtils.incrementPosition(widget.route.id).then((value) {
                    if (value != 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not update position')));
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Position updated')));
                    }
                    setState(() {
                      widget.route.currentPosition += 1;
                    });
                  });
                },
              )
            )
          ),
          Card(
            child: ListTile(
              title: const Text('Packages'),
              subtitle: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Package package = widget.route.packages[index];
                  return ListTile(
                    title: Text('${package.senderContact.firstName} ${package.senderContact.lastName}'),
                    subtitle: Text('${package.receiverContact.firstName} ${package.receiverContact.lastName}'),
                    trailing: Text(package.price.toString()),
                  );
                },
                itemCount: widget.route.packages.length,
              )
            )
          )
        ],
      ),
    );
  }
}
