import 'package:bus_ease/screens/main/ProfileScreen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarBusEase extends AppBar {
  final BuildContext parentContext; // Add this variable

  AppBarBusEase({super.key, required this.parentContext}) // Add this argument
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
                  // Navigate to another screen when CircleAvatar is clicked
                  Navigator.push(
                    parentContext, // Use parentContext instead of context
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/avatar_male.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Add your click handling code here
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