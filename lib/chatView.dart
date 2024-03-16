import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatView(),
    );
  }
}

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat View')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addMessage(_controller.text);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
