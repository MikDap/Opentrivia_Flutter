import 'package:flutter/material.dart';

class ChatActivity extends StatefulWidget {
  @override
  _ChatActivityState createState() => _ChatActivityState();
}

class _ChatActivityState extends State<ChatActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Activity'),
      ),
      body: ChatFragment(),
    );
  }

  void chiamaChat(String idAmico, String nomeAmico) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatFragment(),
      ),
    );
  }
}

class ChatFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Implementa la logica della tua schermata di chat qui
      child: Text('Chat Fragment'),
    );
  }
}