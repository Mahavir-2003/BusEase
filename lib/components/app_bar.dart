import 'package:bus_ease/screens/ticket/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarBusEase extends AppBar {
  final BuildContext parentContext; // Add this variable
  final Function(int) onItemTapped;
  AppBarBusEase(
      {super.key,
      required this.onItemTapped,
      required this.parentContext}) // Rename the 'key' parameter to 'appBarKey'
      : super(
          backgroundColor: const Color(0x00000000),
          automaticallyImplyLeading: false, // Remove the back arrow
          titleSpacing: 14,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  onItemTapped(3);
                },
                child: const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/avatar_male.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // navigate to the QR Scanner screen
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (context) => const QRScanner(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/Scan.svg",
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        );
}
