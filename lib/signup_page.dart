import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor: Color(0xFF533A71), // Set the background color of AppBar to #533A71
      ),
      backgroundColor: Colors.black, // Set the page background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: TextStyle(
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(
                  color: Colors.white70, // Set hint text color to a lighter white
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.white70, // Set hint text color to a lighter white
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              style: TextStyle(
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                hintText: 'Enter a password',
                hintStyle: TextStyle(
                  color: Colors.white70, // Set hint text color to a lighter white
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement signup logic
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF533A71), // Set the button background color to #533A71
              ),
            ),
          ],
        ),
      ),
    );
  }
}
