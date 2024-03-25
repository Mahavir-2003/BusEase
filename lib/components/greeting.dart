import 'package:bus_ease/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Greeting extends StatelessWidget {
  const Greeting({Key? key}) : super(key: key);

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    String greet = getGreeting();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
             const Text(
                'Hello, ',
                style: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${Provider.of<UserProvider>(context, listen: false).user!.firstName} ${Provider.of<UserProvider>(context, listen: false).user!.lastName}',
                style: const TextStyle(
                  letterSpacing: 0.8,
                  color: Color(0xffFBC420),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
           ),
           Text(
            '$greet!',
            style: const TextStyle(
              letterSpacing: 0.8,
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}