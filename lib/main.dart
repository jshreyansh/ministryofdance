import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chatView.dart';
import 'login.dart';
import 'move_description_page.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/chatView': (context) => ChatView(), // Add the dance styles route
        '/login': (context) => LoginScreen(), // Add the dance styles route
        '/move_description': (context) => MoveDetailPage(), // Add the dance styles route

      },
      home: MyHomePage(title: 'Ministry Of Dance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(Duration(milliseconds: 2500), () {
      // Navigate based on the login status after 2.5 seconds
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/chatView'); // Go to chat route if logged in
      } else {
        Navigator.pushReplacementNamed(context, '/login'); // Go to login route if not logged in
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center( // Center widget to center the Column
        child: Text(
          'Hi Im Your Guy', // Update the text
          textAlign: TextAlign.center, // Center align the text
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xffbf9000), // Set the text color to #bf9000
          ),
        ),
      ),
    );
  }
}
