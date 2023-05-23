import 'package:curierat_frontend/classes/transport.dart';
import 'package:curierat_frontend/pages/add_route_page.dart';
import 'package:curierat_frontend/pages/add_transport_page.dart';
import 'package:flutter/material.dart';

import '../classes/my_route.dart';
import '../httpUtils.dart';

class TransportsListView extends StatefulWidget {
  const TransportsListView({Key? key}) : super(key: key);

  @override
  State<TransportsListView> createState() => _TransportsListViewState();
}

class _TransportsListViewState extends State<TransportsListView> {
  List<Transport> transports = [];

  @override
  void initState() {
    HttpUtils.get('/transports').then((value) {
      setState(() {
        transports = List.from(value.map((item) => Transport.fromJson(item)).toList());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 260,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(transports[index].cargoCategory.toString()),
                  title: Text(transports[index].id),
                  subtitle: Text(transports[index].maxWeight.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      HttpUtils.delete('/transports/delete/${transports[index].id}').then((statusCode) {
                        if (statusCode != 200) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transport not deleted')));
                          return;
                        }
                        setState(() {
                          transports.removeAt(index);
                        });
                      });
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                );
              },
              itemCount: transports.length,
            ),
          ),
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AddTransportPage.routeName);
          }, icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
