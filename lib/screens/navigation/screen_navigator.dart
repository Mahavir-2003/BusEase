import 'package:bus_ease/components/app_bar.dart';
import 'package:bus_ease/components/bottom_navigation_bar.dart';
import 'package:bus_ease/screens/main/HistoryScreen/history.dart';
import 'package:bus_ease/screens/main/HomeScreen/home.dart';
import 'package:bus_ease/screens/main/ProfileScreen/profile.dart';
import 'package:bus_ease/screens/main/TicketScreen/ticket.dart';
import 'package:flutter/material.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({Key? key}) : super(key: key);

  @override
  createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final List<Widget> _screens = <Widget>[
    const Home(),
    const Ticket(),
    const History(),
    const Profile(),
  ];

  final PageController _pageController = PageController();

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383E48),
      appBar: AppBarBusEase(parentContext: context , onItemTapped: _onItemTapped),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBarBusEase(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}