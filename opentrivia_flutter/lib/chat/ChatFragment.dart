import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'listaAmici.dart'; // Assicurati di importare il modulo corretto

class ChatFragment extends StatefulWidget {
  final String userId;
  final String username;
  final String chatID;

  ChatFragment({required this.userId, required this.username, required this.chatID});

  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  late FirebaseDatabase database;
  late TextEditingController _editTextController;
  late RecyclerView recyclerView;
  late Button send;
  late String userIdOther;
  late String usernameOther;
  late String chatID;
  late String uid;
  late String displayName;
  late DatabaseReference chatRef;
  late ChatAdapter adapter;

  @override
  void initState() {
    super.initState();
    _editTextController = TextEditingController();
    database = FirebaseDatabase.instance;
    uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    displayName = FirebaseAuth.instance.currentUser?.displayName ?? "";
    chatRef = FirebaseDatabase.instance.reference().child("chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $usernameOther'),
      ),
      body: _buildChatView(),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            // Replace with your own logic for displaying messages
            itemCount: 10, // Example itemCount
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Message $index'),
              );
            },
          ),
        ),
        _buildInputField(),
      ],
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _editTextController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _editTextController.text.trim();
    if (message.isNotEmpty) {
      // Replace with your logic to send messages
      print('Sending message: $message');

      _editTextController.clear();
    }
  }

  @override
  void dispose() {
    _editTextController.dispose();
    super.dispose();
  }
}
