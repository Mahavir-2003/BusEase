import 'package:bus_ease/screens/auth/LoginScreen/login.dart';
import 'package:bus_ease/screens/main/HomeScreen/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusEase',
      // Define routes
      routes: {
        '/': (context) => const Login(), // Initial route
        '/home': (context) => const Home(),
      },
      initialRoute: '/', // Initial route set to login page
    );
  }
}