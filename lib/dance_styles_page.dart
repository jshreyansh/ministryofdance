import 'package:flutter/material.dart';

class DanceStylesPage extends StatelessWidget {
  // Define an array of dance styles
  final List<String> danceStyles = [
    'House',
    'Hip-Hop',
    'Vogue',
    'Bollywood',
    'Krump',
    'Bboy',
    'Wacking',
    'Locking',
    'Popping',
    'Boogloo',
    'Memphin Junkins',
    'Ballet',
    'Dancehall',
  ];

  // Function to create a list of ElevatedButtons from the danceStyles array
  List<Widget> buildDanceStyleButtons(BuildContext context) {
    return danceStyles.map((style) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
        height: 68.0, // Reduce the button's height by 40%
        margin: EdgeInsets.only(bottom: 40.0), // Add more spacing between list tiles
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF533A71), // Set button background color to 0xFF533A71
            onPrimary: Colors.white, // Set text color to white
            padding: EdgeInsets.all(16), // Increase padding for spacing
            alignment: Alignment.center, // Center the text
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Rounded boundaries
            ),
            elevation: 5, // Add elevation to the button
            shadowColor: Colors.white, // Set shadow color to white
          ),
          onPressed: () {
            // Handle the button action, e.g., navigate to the dance realm
            Navigator.pushNamed(context, '/moves_listing');
          },
          child: Text(
            style,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white, // Text color is white
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100), // Add 40px padding at the top
            Text(
              'CHOOSE YOUR VIBE',
              style: TextStyle(
                fontSize: 28, // Reduce the heading's font size by 40%
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color is white
              ),
            ),
            SizedBox(height: 40), // Add 40px padding at the bottom
            Expanded(
              child: ListView(
                children: buildDanceStyleButtons(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
