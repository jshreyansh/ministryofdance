import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page
import 'signup_page.dart'; // Import the signup page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ...

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ...
      routes: {
        '/login': (context) => LoginPage(),   // Add the login page route
        '/signup': (context) => SignupPage(), // Add the signup page route
      },
      home:  MyHomePage(title: 'Ministry Of Dance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ...
  final String title; // Add this line

  MyHomePage({required this.title}); // Add this constructor

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF533A71), // Set header background color
        title: Text(
          'MINISTRY OF DANCE', // Header text
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black, // Set page background color to black
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Path to your logo image
                  height: 100, // Adjust the height as needed
                ),
                SizedBox(height: 20), // Add some spacing
                Text(
                  'Elevating dancers through tradition, technology, and AI at Ministry of Dance.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xFF533A71),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                tooltip: 'Login',
                child: const Icon(Icons.login, color: Colors.white),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                backgroundColor: Color(0xFF533A71),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                tooltip: 'Sign Up',
                child: const Icon(Icons.person_add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
