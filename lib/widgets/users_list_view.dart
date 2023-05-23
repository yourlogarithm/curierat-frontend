import 'package:curierat_frontend/httpUtils.dart';
import 'package:flutter/material.dart';

import '../classes/user.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  List<User> users = [];

  @override
  void initState() {
    HttpUtils.get('/users').then((value) {
      setState(() {
        users = List.from(value.map((item) => User.fromJson(item)).toList());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 260,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].username),
                  subtitle: Text(users[index].email),
                  trailing: IconButton(
                    onPressed: () {
                      HttpUtils.get('/users/delete/${users[index].username}').then((value) {
                        if (value['message'] != 'User deleted') {
                          debugPrint('User not deleted');
                          return;
                        }
                        setState(() {
                          users.removeAt(index);
                        });
                      });
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                );
              },
              itemCount: users.length,
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
