import 'package:curierat_frontend/widgets/routes_list_view.dart';
import 'package:curierat_frontend/widgets/users_list_view.dart';
import 'package:flutter/material.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          children: [
            UsersListView(),
            RoutesListView()
          ],
        ),
    );
  }
}
