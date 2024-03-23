import 'package:bus_ease/screens/additional/profile_Settings/account.dart';
import 'package:bus_ease/screens/additional/profile_Settings/help_center.dart';
import 'package:bus_ease/screens/additional/profile_Settings/paas_validity.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff383E48),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundImage:
                        AssetImage('assets/images/3d_avatar_21.jpg'),
                  ),
                  _buildCircularPercentIndicator(0.8),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Dhruv Patel',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 65),
              // Correct placement of _buildInfoBox
             _buildInfoBox("Account",const Account()),
              _buildInfoBox("Pass validity", const PassValidity()),
              _buildInfoBox("Help Center", const HelpCenter()),


            ],
          ),
        ),
         ),
    );
  }
Widget _buildInfoBox(String text, Widget destinationPage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, right: 18, left: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(84, 85, 96, 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the specified destination page when the arrow is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationPage),
              );
            },
            child: const Icon(
              Icons.keyboard_arrow_right_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularPercentIndicator(double percent) {
    return CircularPercentIndicator(
      radius: 93,
      lineWidth: 4.0,
      percent: percent,
      backgroundColor: const Color(0xff383E48),
      progressColor: Colors.yellow,
    );
  }
}