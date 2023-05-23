import 'package:curierat_frontend/pages/add_route_page.dart';
import 'package:curierat_frontend/pages/route_page.dart';
import 'package:flutter/material.dart';

import '../classes/my_route.dart';
import '../httpUtils.dart';

class RoutesListView extends StatefulWidget {
  const RoutesListView({Key? key}) : super(key: key);

  @override
  State<RoutesListView> createState() => _RoutesListViewState();
}

class _RoutesListViewState extends State<RoutesListView> {
  List<MyRoute> routes = [];

  @override
  void initState() {
    HttpUtils.get('/routes').then((value) {
      setState(() {
        routes = List.from(value.map((item) => MyRoute.fromJson(item)).toList());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[500],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 260,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutePage.routeName, arguments: routes[index]);
                  },
                  child: ListTile(
                    title: Text(routes[index].cities.join(', ')),
                    subtitle: Text(routes[index].transport),
                    trailing: IconButton(
                      onPressed: () {
                        HttpUtils.delete('/routes/delete/{id}?id_=${routes[index].id}').then((statusCode) {
                          if (statusCode != 200) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Route not deleted')));
                            return;
                          }
                          setState(() {
                            routes.removeAt(index);
                          });
                        });
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                );
              },
              itemCount: routes.length,
            ),
          ),
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AddRoutePage.routeName);
          }, icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
