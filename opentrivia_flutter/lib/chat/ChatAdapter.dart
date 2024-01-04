import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:collection';

class ChatAdapter extends StatefulWidget {
  final String chatID;

  ChatAdapter({required this.chatID});

  @override
  _ChatAdapterState createState() => _ChatAdapterState();
}

class _ChatAdapterState extends State<ChatAdapter> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _chatRef;
  late String _uid;
  late Map<int, Triple<String, String, int>> _userMessages;
  late String _controlloData;

  @override
  void initState() {
    super.initState();
    _uid = _auth.currentUser!.uid;
    _chatRef = _database.reference().child("chat");
    _userMessages = HashMap<int, Triple<String, String, int>>();
    _controlloData = "0";
    _leggiMessaggiDatabase();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  void _chiamaChat(String idAmico, String nomeAmico) {
    // Implementa la logica per aprire la chat con l'amico specifico
  }

  void _leggiMessaggiDatabase() {
    _chatRef.child(widget.chatID).onValue.listen((Event event) {
      DataSnapshot listachat = event.snapshot;
      DataSnapshot messaggichat = listachat.child("messaggi");
      int position = 0;

      messaggichat.children.forEach((messaggio) {
        String testo = messaggio.child("testo").value.toString();
        String mittente = messaggio.child("mittente").value.toString();
        int timestamp = messaggio.child("timestamp").value;

        _userMessages[position] = Triple(testo, mittente, timestamp);
        position++;
      });

      // Notifica l'adattatore che i dati sono stati modificati
      setState(() {});

      if (_userMessages.isNotEmpty && _userMessages.length > 1) {
        // chatFragment.recyclerView.smoothScrollToPosition(chatFragment.adapter.itemCount - 1);
      }
    });
  }

  void _removeListener() {
    _chatRef.child(widget.chatID).off();
  }

  String _getNomeMese(int numeroMese) {
    switch (numeroMese) {
      case 1:
        return "Gennaio";
      case 2:
        return "Febbraio";
      case 3:
        return "Marzo";
      case 4:
        return "Aprile";
      case 5:
        return "Maggio";
      case 6:
        return "Giugno";
      case 7:
        return "Luglio";
      case 8:
        return "Agosto";
      case 9:
        return "Settembre";
      case 10:
        return "Ottobre";
      case 11:
        return "Novembre";
      case 12:
        return "Dicembre";
      default:
        return "Mese non valido";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _userMessages.length,
      itemBuilder: (context, position) {
        int messaggioKey = _userMessages.keys.elementAt(position);
        Triple<String, String, int> messaggio = _userMessages[messaggioKey]!;

        // Crea un oggetto DateTime e impostalo con il timestamp
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(messaggio.third);

        // Ottieni il giorno, il mese e l'orario
        int giorno = dateTime.day;
        int mese = dateTime.month;
        String orario = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

        String nomeMese = _getNomeMese(mese);

        String data = nomeMese + " " + giorno.toString();

        return ListTile(
          title: Text(data),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orario),
              Text(messaggio.first),
            ],
          ),
          // Aggiungi qui altri widget o personalizzazioni necessari
        );
      },
    );
  }
}

class Triple<A, B, C> {
  final A first;
  final B second;
  final C third;

  Triple(this.first, this.second, this.third);
}
