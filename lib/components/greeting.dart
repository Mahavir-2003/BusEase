
import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  const Greeting({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              Text(
                'Hello, ',
                style: TextStyle(
                  letterSpacing: 0.8,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Mahavir Patel',
                style: TextStyle(
                  letterSpacing: 0.8,
                  color: Color(0xffFBC420),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
           ),
           Text(
            'Good Morning!',
            style: TextStyle(
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