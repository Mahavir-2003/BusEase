import 'package:bus_ease/components/greeting.dart';
import 'package:bus_ease/components/pass_calander.dart';
import 'package:bus_ease/components/ticket_small.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Greeting(),
        SizedBox(
          height: 10,
        ),
        TicketSmall(),
        SizedBox(
          height: 15,
        ),
        PassCalander(),
      ],
      ),
    );
  }
}