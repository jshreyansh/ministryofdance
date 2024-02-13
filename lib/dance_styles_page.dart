import 'package:flutter/material.dart';
import 'dart:async';

class DanceStylesPage extends StatefulWidget {
  @override
  _DanceStylesPageState createState() => _DanceStylesPageState();
}

class _DanceStylesPageState extends State<DanceStylesPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Schedule the initial messages with a 2-second gap between them
    Timer(Duration(seconds: 2), () {
      _addMessage(Message(text: 'Hi', isSentByMe: false), animate: true);
      Timer(Duration(seconds: 2), () {
        _addMessage(Message(text: 'I\'m Your Guy to help you with your Expense Sir', isSentByMe: false), animate: true);
      });
    });
  }

  void _addMessage(Message message, {bool animate = false}) {
    final int index = _messages.length;
    _messages.add(message);
    if (animate) {
      _listKey.currentState?.insertItem(index);
    }
  }

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      _addMessage(Message(text: text, isSentByMe: true), animate: true);
      _controller.clear();

      // Simulate fetching response from the API after a 1-second delay
      Future.delayed(Duration(seconds: 1), () {
        String apiResponse = 'Dummy response from API...';
        _addMessage(Message(text: apiResponse.substring(0, 20), isSentByMe: false), animate: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5b5b5b),
        title: Text(
          "My Guy",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.person, color: Color(0xffbf9000)),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              padding: EdgeInsets.only(top: 8.0), // Increased padding from the top
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final message = _messages[index];
                return SlideTransition(
                  position: animation.drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
                  child: Align(
                    alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: message.isSentByMe ? Color(0xffbf9000) : Colors.grey[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Color(0xffbf9000), // Set the send button color to #bf9000
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/moves_listing');
  }
}

class Message {
  String text;
  bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}
