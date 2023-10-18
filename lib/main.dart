import 'package:flutter/material.dart';
import 'dance_styles_page.dart';
import 'moves_listing_page.dart';
import 'move_description_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/dance_styles': (context) => DanceStylesPage(), // Add the dance styles route
        '/moves_listing': (context) => MoveListingPage(), // Add the dance styles route
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'Ministry Of Dance',
            style: TextStyle(
              fontSize: 30, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
              color: Color(0xFF533A71),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/logo.png',
              height: 100,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF533A71),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/dance_styles'); // Navigate to the dance styles page
            },
            child: Text(
              'Enter Dance Realm',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
