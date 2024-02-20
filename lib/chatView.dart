import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isNotEmpty) {
      _addMessage(Message(text: text, isSentByMe: true), animate: true);
      _controller.clear();
      await _fetchResponseFromAPI(text);
    }
  }

  Future<void> _fetchResponseFromAPI(String query) async {
    final url = Uri.parse('https://personal-agent-backend.onrender.com/api/chat_now');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "user_message": query,
      "id": "24"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if 'result' is not null
        if (data['result'] != null) {
          // Use the 'result' field to display the message
          _addMessage(Message(text: data['result'], isSentByMe: false), animate: true);
        } else {
          // Handle the case where 'result' is null
          _addMessage(Message(text: 'No result found.', isSentByMe: false), animate: true);
        }
      } else {
        // Log error status code
        _addMessage(Message(text: 'Error fetching data: ${response.statusCode}', isSentByMe: false), animate: true);
      }
    } catch (e) {
      // Log any exceptions
      _addMessage(Message(text: 'Error: $e', isSentByMe: false), animate: true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5b5b5b),
        title: Text("My Guy", style: TextStyle(color: Colors.white)),
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
              padding: EdgeInsets.only(top: 8.0),
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
                      child: Text(message.text, style: TextStyle(color: Colors.white)),
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
                  color: Color(0xffbf9000),
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
