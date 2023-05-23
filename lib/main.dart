import 'package:curierat_frontend/pages/add_route_page.dart';
import 'package:curierat_frontend/pages/home_page.dart';
import 'package:curierat_frontend/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curierat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AddRoutePage.routeName: (context) => const AddRoutePage(),
      }
    );
  }
}