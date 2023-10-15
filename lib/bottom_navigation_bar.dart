import 'package:flutter/material.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Function(BuildContext) showUpdatePopup;

  HomePageBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    required this.showUpdatePopup,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF533A71),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Communities',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Learning',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }
}
