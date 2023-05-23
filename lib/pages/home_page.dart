import 'package:curierat_frontend/pages/add_package_page.dart';
import 'package:curierat_frontend/pages/admin_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(child: AdminLayout()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPackagePage.routeName);
        }
      ),
    );
  }
}
