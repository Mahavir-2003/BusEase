import 'dart:async';
import 'package:bus_ease/providers/ticket_provider.dart';
import 'package:bus_ease/providers/user_provider.dart';
import 'package:bus_ease/screens/auth/LoginScreen/login.dart';
import 'package:bus_ease/screens/navigation/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TicketProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
    fetchUser();
  }

  Future<void> fetchUser() async {
    await Provider.of<UserProvider>(context, listen: false).fetchUser();
    bool isLoggedIn = false;
    if(context.mounted){
      isLoggedIn = Provider.of<UserProvider>(context, listen: false).user != null;
    }
    if (isLoggedIn) {
      if(context.mounted){
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if(context.mounted){
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
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