import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _authToken;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
    _initialGreeting();
  }

  Future<void> _initialGreeting() async {
    String name = '';
    if (_authToken == 'token_for_8770026706') {
      name = 'Shreyansh';
    } else if (_authToken == 'token_for_9929995821') {
      name = 'Arpit';
    }

    Timer(Duration(seconds: 1), () {
      _addMessage(Message(text: 'Hi, $name', isSentByMe: false));
      Timer(Duration(seconds: 1), () {
        _addMessage(Message(text: "I'm Your Guy to help you with your Expense Sir, $name", isSentByMe: false));
      });
    });
  }

  void _addMessage(Message message) {
    _messages.add(message);
    _listKey.currentState?.insertItem(_messages.length - 1);
    Timer(Duration(milliseconds: 100), () => _scrollToBottom());
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _addMessage(Message(text: text, isSentByMe: true));
      _controller.clear();
      await _saveMessage(text);

      // Instant response with the name based on authToken
      String name = _authToken == 'token_for_8770026706' ? 'Shreyansh' : 'Arpit';
      Timer(Duration(milliseconds: 500), () {
        _addMessage(Message(text: "Noted $name Sir", isSentByMe: false));
      });
    }
  }

  Future<void> _saveMessage(String text) async {
    if (_authToken == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'sentMessages_$_authToken';
    List<String> messages = prefs.getStringList(key) ?? [];
    messages.add(text);
    await prefs.setStringList(key, messages);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 60,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(000000),
        title: Text("AiPal", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Color(0xffbf9000)),
            onPressed: _fetchAndShowSavedMessages,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Logout'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert, color: Color(0xffbf9000)),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: 10),
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final message = _messages[index];
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(Tween(begin: Offset(0, 0.1), end: Offset.zero)),
                    child: Align(
                      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: message.isSentByMe ? Color(0xffbf9000) : Colors.grey[700],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(message.text, style: TextStyle(color: Colors.white)),
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
                  icon: Icon(Icons.send, color: Color(0xffbf9000)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchAndShowSavedMessages() async {
    if (_authToken == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'sentMessages_$_authToken';
    List<String> messages = prefs.getStringList(key) ?? [];

    messages.forEach((message) {
      _addMessage(Message(text: message, isSentByMe: false));
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

class Message {
  String text;
  bool isSentByMe;
  Message({required this.text, required this.isSentByMe});
}
