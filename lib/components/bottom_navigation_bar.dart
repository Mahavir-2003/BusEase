import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarBusEase extends StatefulWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  const BottomNavigationBarBusEase({
    Key? key,
    required this.onItemTapped,
    required this.currentIndex,
  }) : super(key: key);

  @override
  createState() => _BottomNavigationBarBusEaseState();
}

class _BottomNavigationBarBusEaseState
    extends State<BottomNavigationBarBusEase> {
  void _onItemTapped(int index) {
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(0xff282B2F),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            currentIndex: widget.currentIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xffFBC420),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 0),
                  child: SvgPicture.asset(
                    'assets/icons/Home.svg',
                    height: 26,
                    width: 26,
                    color: widget.currentIndex == 0
                        ? const Color(0xffFBC420)
                        : Colors.white,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 0),
                  child: SvgPicture.asset(
                    'assets/icons/Ticket.svg',
                    height: 18,
                    width: 18,
                    color: widget.currentIndex == 1
                        ? const Color(0xffFBC420)
                        : Colors.white,
                  ),
                ),
                label: 'Ticket',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 0),
                  child: SvgPicture.asset(
                    'assets/icons/History.svg',
                    height: 20,
                    width: 20,
                    color: widget.currentIndex == 2
                        ? const Color(0xffFBC420)
                        : Colors.white,
                  ),
                ),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 0),
                  child: SvgPicture.asset(
                    'assets/icons/Profile.svg',
                    height: 28,
                    width: 28,
                    color: widget.currentIndex == 3
                        ? const Color(0xffFBC420)
                        : Colors.white,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}