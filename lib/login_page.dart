import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String getEmail() {
    return emailController.text;
  }

  String getPassword() {
    return passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
              controller: emailController,
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
              controller: passwordController,
              obscureText: true,
              style: TextStyle(
                color: Colors.white, // Set text color to white
              ),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Colors.white70, // Set hint text color to a lighter white
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the entered email and password
                String enteredEmail = getEmail();
                String enteredPassword = getPassword();

                // Check if the entered email and password match the specific values
                if (enteredEmail == 'jshreyansh34@gmail.com' && enteredPassword == '17Je003188') {
                  // Navigate to the home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(showUpdatePopup: _showUpdatePopup)),
                  );
                } else {
                  // TODO: Show an error message for incorrect credentials
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Set the button background color to #533A71
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
