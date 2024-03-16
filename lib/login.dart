import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'otp_input_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';

  Future<void> _validateAndNavigate() async {
    final String inputNumber = _controller.text;
    const Map<String, String> validNumbersAndTokens = {
      '8770026706': 'token_for_8770026706',
      '9929995821': 'token_for_9929995821',
    };

    if (validNumbersAndTokens.containsKey(inputNumber)) {
      // Clear error message
      setState(() {
        _errorMessage = '';
      });

      // Save the token associated with the number in shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', validNumbersAndTokens[inputNumber]!);

      // Retrieve the token from shared preferences (demonstration)
      final String? retrievedToken = prefs.getString('authToken');
      print('Retrieved token: $retrievedToken'); // For debugging purposes

      // Navigate to OTPInputScreen with dummy data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPInputScreen(
            verificationId: '123456', // Dummy verification ID
            phoneNumber: inputNumber,
            authToken: retrievedToken ?? 'default_token', // Use retrieved token or a default one
          ),
        ),
      );
    } else {
      // Show error message
      Fluttertoast.showToast(msg: 'Invalid number, please try again.');
      setState(() {
        _errorMessage = 'Invalid number, please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Login with ID',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbf9000),
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
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffbf9000),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: _validateAndNavigate,
                  child: Text(
                    'Let\'s Chat',
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
                  textAlign: TextAlign.left,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
