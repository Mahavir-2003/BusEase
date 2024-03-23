import 'package:flutter/material.dart';

class PassValidity extends StatelessWidget {
  const PassValidity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "This is the pass validity page",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}