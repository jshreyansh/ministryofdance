import 'package:flutter/material.dart';
import 'move_description_page.dart'; // Import your move description page

class MoveListingPage extends StatelessWidget {
  // Define an array of dance styles
  final List<String> danceStyles = [
    'The Wop',
    'Running Man',
    'Mike Tyson',
    'Gucci',
    'Smurf',
    'Steve Martin',
    'Robocop',
    'Stomp',
    'BK Bounce (Brooklyn Bounce, Criss Cross)',
    'Basketball',
    'ATL/A-Town Stomp',
    'Harlem Shake',
    'Dice Game',
    'Roger Rabbit (Reject)',
    'Bart Simpson',
    'The Prep',
    'Wu-Tang',
    'Bankhead Bounce',
    'Monastery',
    'The Snake',
  ];

  // Function to create a list of ElevatedButtons from the danceStyles array
  List<Widget> buildMovesButtons(BuildContext context) {
    return danceStyles.map((style) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 58.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF533A71),
            onPrimary: Colors.white,
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5,
            shadowColor: Colors.white,
          ),
          onPressed: () {
            // Handle the button action, navigate to the move description page
            Navigator.pushNamed(context, '/move_description');
          },
          child: Text(
            style,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF533A71),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              'HIP HOP DICTIONARY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: buildMovesButtons(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
