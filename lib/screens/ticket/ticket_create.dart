import 'package:flutter/material.dart';

class TicketCreate extends StatefulWidget {
  final String bus_number;

  TicketCreate({required this.bus_number, Key? key}) : super(key: key);

  @override
  _TicketCreateState createState() => _TicketCreateState();
}

class _TicketCreateState extends State<TicketCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Create'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bus Number: ${widget.bus_number}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}