import 'package:flutter/material.dart';
import 'account_page.dart';
import 'bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final Function(BuildContext) showUpdatePopup;

  HomePage({required this.showUpdatePopup});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _showUpdatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hold On'),
          content: Text('We\'ll be back with the updates soon'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Home Dancers',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF533A71),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Welcome home dancers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(
        showUpdatePopup: widget.showUpdatePopup,
        selectedIndex: _selectedIndex, // Add selectedIndex parameter
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(showUpdatePopup: widget.showUpdatePopup)));
          } else {
            _showUpdatePopup(context);
          }
        },
      ),
    );
  }
}
