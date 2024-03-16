import 'package:flutter/material.dart';
import 'chatView.dart';

import 'package:shared_preferences/shared_preferences.dart';
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
        '/chatView': (context) => ChatView(),
        '/login': (context) => LoginScreen(),
        '/move_description': (context) => MoveDetailPage(),
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
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/chatView');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFFDCB21C),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'AiPal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
