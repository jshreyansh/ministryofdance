import 'package:flutter/material.dart';

class MoveDetailPage extends StatefulWidget {
  @override
  _MoveDetailPageState createState() => _MoveDetailPageState();
}

class _MoveDetailPageState extends State<MoveDetailPage> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF533A71), // Set header color
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'The Wop',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Description of The Wop goes here',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF533A71), // Set tab background color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                buildTab('Move', 0),
                buildTab('Music', 1),
                buildTab('Groove', 2),
              ],
            ),
          ),
          _currentTabIndex == 0
              ? buildMoveTab() // Show move tab
              : _currentTabIndex == 1
              ? buildMusicTab() // Show music tab
              : buildGrooveTab(), // Show groove tab
        ],
      ),
    );
  }

  Widget buildTab(String text, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _currentTabIndex == index ? Colors.white : null,
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? Radius.circular(20) : Radius.zero,
              topRight: index == 2 ? Radius.circular(20) : Radius.zero,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: _currentTabIndex == index
                  ? Color(0xFF533A71)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMoveTab() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add your image scroller here
          ],
        ),
      ),
    );
  }

  Widget buildMusicTab() {
    return Expanded(
      child: Center(
        child: Text('Random Music Text'),
      ),
    );
  }

  Widget buildGrooveTab() {
    return Expanded(
      child: Center(
        child: Text('Random Groove Text'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MoveDetailPage(),
  ));
}
