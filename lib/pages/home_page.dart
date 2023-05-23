import 'package:curierat_frontend/httpUtils.dart';
import 'package:curierat_frontend/pages/admin_layout.dart';
import 'package:curierat_frontend/widgets/users_list_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AdminLayout(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint(HttpUtils.getAccessToken());
          }
      ),
    );
  }
}
