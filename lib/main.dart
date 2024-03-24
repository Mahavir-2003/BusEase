import 'dart:async';
import 'package:bus_ease/screens/auth/LoginScreen/login.dart';
import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:bus_ease/services/auth_service.dart';
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
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/home': (context) => const ScreenNavigator(),
      },
      initialRoute: '/',
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      bool isLoggedIn = await AuthService().isLoggedIn();
      if (isLoggedIn) {
        if(context.mounted){
        Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if(context.mounted){
        Navigator.pushReplacementNamed(context, '/login');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}