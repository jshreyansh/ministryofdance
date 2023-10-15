import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart'; // Import the BottomNavigationBar class

class AccountPage extends StatelessWidget {
  final Function(BuildContext) showUpdatePopup;

  AccountPage({required this.showUpdatePopup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF533A71),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to your account page!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateBackToHomePage(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(
        showUpdatePopup: showUpdatePopup,
        onTap: (index) {}, // Add an empty onTap function here
        selectedIndex: 3, // Set the selectedIndex to highlight "Account" icon
      ),
    );
  }

  void _navigateBackToHomePage(BuildContext context) {
    Navigator.pop(context); // Navigate back to the previous page (home page)
  }
}
