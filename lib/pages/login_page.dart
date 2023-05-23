import 'package:flutter/material.dart';

import '../httpUtils.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                controller: _usernameTextEditingController,
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        HttpUtils.login(_usernameTextEditingController.text, _passwordTextEditingController.text).then((_) => {
                          if (HttpUtils.getAccessToken() != null) {
                            Navigator.of(context).pushReplacementNamed('/home')
                          }
                        });
                      },
                      icon: const Icon(Icons.send))
                ),
                controller: _passwordTextEditingController,
              )
            ],
          )
        )
      )
    );
  }
}
