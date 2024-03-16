import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPInputScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String authToken;

  OTPInputScreen({Key? key, required this.verificationId, required this.phoneNumber, required this.authToken}) : super(key: key);

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  final _otpControllerOne = TextEditingController();
  final _otpControllerTwo = TextEditingController();
  final _otpControllerThree = TextEditingController();
  final _otpControllerFour = TextEditingController();

  final _focusNodeOne = FocusNode();
  final _focusNodeTwo = FocusNode();
  final _focusNodeThree = FocusNode();
  final _focusNodeFour = FocusNode();

  String _errorMessage = '';

  Future<void> _validateOTPAndNavigate() async {
    String enteredOTP = _otpControllerOne.text +
        _otpControllerTwo.text +
        _otpControllerThree.text +
        _otpControllerFour.text;

    // Expected OTPs for specific phone numbers
    final Map<String, String> expectedOTPForNumber = {
      '8770026706': '5504',
      '9929995821': '1234',
    };

    // Retrieve the authToken from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedAuthToken = prefs.getString('authToken');

    if (storedAuthToken == widget.authToken &&
        enteredOTP == expectedOTPForNumber[widget.phoneNumber]) {
      // Simulate successful OTP verification
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushNamed(context, '/chatView'); // Ensure you have defined this route
    } else {
      setState(() {
        _errorMessage = 'Invalid OTP, please try again.';
      });
    }
  }

  @override
  void dispose() {
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
                color: Color(0xffbf9000),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                backgroundColor: Color(0xffbf9000),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: _validateOTPAndNavigate,
              child: Text('Verify OTP'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
