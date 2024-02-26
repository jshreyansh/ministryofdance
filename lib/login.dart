import 'package:flutter/material.dart';
import 'otp_input_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  // final List<String> validNumbers = ['8770026706', '9929995821', '9340112067'];
  String _errorMessage = '';
  String _phoneNumber = '';
  String _verificationId = '';
  String _token = '';

  // void _validateAndNavigate() {
  //   if (validNumbers.contains(_controller.text)) {
  //     // Clear error message
  //     setState(() {
  //       _errorMessage = '';
  //     });
  //     // Navigate to OTP input screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => OTPInputScreen()),
  //     );
  //   } else {
  //     // Show error message
  //     setState(() {
  //       _errorMessage = 'Invalid number, please try again.';
  //     });
  //   }
  // }

  void _validateAndNavigate() async {
    final String inputNumber = _controller.text;

    // Validate input
    if (inputNumber.length == 10 &&
        inputNumber.runes.every((r) => r >= 48 && r <= 57)) {
      // Clear error message
      setState(() {
        _errorMessage = '';
      });

      try {
        // Replace with your actual endpoint and adjust parameters as necessary
        final response = await http.post(
          Uri.parse('https://personal-agent-backend.onrender.com/api/sign_up'),
          headers: {'Content-Type': 'application/json'},
          body: '{"phone_number": "$inputNumber"}',
        );
        if (response.statusCode == 200) {
          final responseData =
              json.decode(response.body); // Decode the JSON response body
          // print('response>>>>>>>>>>>$responseData     $responseData['data']['mobileNumber']');

          setState(() {
            _phoneNumber = responseData['data']['mobileNumber']; // Access decoded data
            _verificationId =
                responseData['data']['verificationId']; // Access decoded data
            _token =
                responseData['message_central_token']; // Access decoded data
          });
          // Assuming the API responds with a 200 status on success
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPInputScreen(
                verificationId: _verificationId,
                phoneNumber: _phoneNumber,
                authToken: _token,
              ),
            ),
          );
        } else {
          // Handle server-side error
          Fluttertoast.showToast(msg: 'Failed to send OTP. Please try again.');
        }
      } catch (e) {
        // Handle network error
        print('object>>>>>>>>$e');
        Fluttertoast.showToast(msg: 'Network error. Please try again.');
      }
    } else {
      // Show error toast
      Fluttertoast.showToast(
          msg: 'Invalid number. Please enter a valid 10-digit number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Login with ID ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbf9000), // Gold color for the text
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your ID',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffbf9000)),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight, // Align button to the right
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                        0xffbf9000), // Set button background color to #bf9000
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: _validateAndNavigate,
                  child: Text(
                    'Lets Chat',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.left, // Align error text to the left
                ),
              ),
          ],
        ),
      ),
    );
  }
}
