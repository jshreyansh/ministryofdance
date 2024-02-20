import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPInputScreen extends StatefulWidget {
  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  // Define a TextEditing Controller for each OTP digit
  final _otpControllerOne = TextEditingController();
  final _otpControllerTwo = TextEditingController();
  final _otpControllerThree = TextEditingController();
  final _otpControllerFour = TextEditingController();

  // Define a FocusNode for each input field
  final _focusNodeOne = FocusNode();
  final _focusNodeTwo = FocusNode();
  final _focusNodeThree = FocusNode();
  final _focusNodeFour = FocusNode();

  final String _validOTP = '4444'; // Hardcoded OTP for demonstration
  String _errorMessage = '';

  Future<void> _validateOTPAndNavigate() async {
    String enteredOTP = _otpControllerOne.text + 
                      _otpControllerTwo.text + 
                      _otpControllerThree.text + 
                      _otpControllerFour.text;
    if (enteredOTP == _validOTP) {
      // OTP is valid, navigate to chat view
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			await prefs.setBool('isLoggedIn', true);

      Navigator.pushNamed(context, '/chatView'); // Make sure this route is defined in your app
    } else {
      // Show error message
      setState(() {
        _errorMessage = 'Invalid OTP, please try again.';
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _otpControllerOne.dispose();
    _otpControllerTwo.dispose();
    _otpControllerThree.dispose();
    _otpControllerFour.dispose();
    _focusNodeOne.dispose();
    _focusNodeTwo.dispose();
    _focusNodeThree.dispose();
    _focusNodeFour.dispose();
    super.dispose();
  }

  void _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xffbf9000), // Gold color for the text
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // OTP input blocks
                _otpInputField(_otpControllerOne, _focusNodeOne, _focusNodeTwo),
                SizedBox(width: 10),
                _otpInputField(_otpControllerTwo, _focusNodeTwo, _focusNodeThree),
                SizedBox(width: 10),
                _otpInputField(_otpControllerThree, _focusNodeThree, _focusNodeFour),
                SizedBox(width: 10),
                _otpInputField(_otpControllerFour, _focusNodeFour, null),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffbf9000), // Button color
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: _validateOTPAndNavigate,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpInputField(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: currentFocus,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(fontSize: 24, color: Colors.white),
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffbf9000)),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (value) {
            if (value.length == 1 && nextFocus != null) {
              _nextFocus(nextFocus);
            }
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
