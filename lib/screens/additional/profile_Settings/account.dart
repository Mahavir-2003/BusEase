import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "This is the Account page",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}