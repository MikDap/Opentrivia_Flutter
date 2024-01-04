import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'chat_fragment.dart'; // Assicurati di importare il modulo corretto

class ChatListaAmici extends StatefulWidget {
  @override
  _ChatListaAmiciState createState() => _ChatListaAmiciState();
}

class _ChatListaAmiciState extends State<ChatListaAmici> {
  late RecyclerView recyclerView;
  final userKeyMap = Map<String, String>(); // Chiave: ID utente, Valore: Nome amico
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();
  final displayname = FirebaseAuth.instance.currentUser?.displayName.toString();
  final amiciRef = FirebaseDatabase.instance.reference().child("users").child(uid).child("amici");
  final userRef = FirebaseDatabase.instance.reference().child("users").child(uid);
  final chatMiaRef = FirebaseDatabase.instance.reference().child("users").child(uid).child("chat");
  late String chatID;
  late String userIDOther;
  late String usernameOther;
  late DatabaseReference chatRef;
  late ValueEventListener userRefListener;
  late ValueEventListener amiciRefListener;
  var userRefListenerInitialized = false;
  var amiciRefListenerInitialized = false;

  @override
  void initState() {
    super.initState();
    chatRef = FirebaseDatabase.instance.reference().child("chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Lista Amici'),
      ),
      body: _buildChatView(),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: userKeyMap.length,
            itemBuilder: (context, index) {
              final userId = userKeyMap.keys.elementAt(index);
              final username = userKeyMap[userId];
              return ListTile(
                title: Text(username ?? ''),
                onTap: () {
                  _onAmicoClick(userId, username ?? '');
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onAmicoClick(String userId, String username) {
    userIDOther = userId;
    usernameOther = username;

    userRefListener = userRef.onValue.listen((Event user) {
      if (user.snapshot.hasChild("chat")) {
        final listachat = user.snapshot.child("chat");
        final listachatIterator = listachat.children.iterator();

        controllaChat(listachatIterator, userId, false, () {
          final chatFragment = ChatFragment();
          final bundle = Bundle();
          bundle.putString("userId", userId);
          bundle.putString("username", username);
          bundle.putString("chatID", chatID);
          chatFragment.setArguments(bundle);

          final transaction = requireActivity().getSupportFragmentManager().beginTransaction();
          transaction.replace(R.id.fragmentContainerViewChat, chatFragment);
          transaction.addToBackStack(null);
          transaction.commit();
        });
      } else {
        final userOtherRef = FirebaseDatabase.instance.reference().child("users").child(userIDOther);
        final nuovaChatRef = userRef.child("chat").push();
        chatID = nuovaChatRef.key.toString();

        userOtherRef.child("chat").child(chatID).child("partecipante").child(uid).setValue(displayname);
        final settato = userRef.child("chat").child(chatID).child("partecipante").child(userIDOther).setValue(usernameOther);

        settato.then((_) {
          setPartecipanti();

          final chatFragment = ChatFragment();
          final bundle = Bundle();
          bundle.putString("userId", userId);
          bundle.putString("username", username);
          bundle.putString("chatID", chatID);
          chatFragment.setArguments(bundle);

          final transaction = requireActivity().getSupportFragmentManager().beginTransaction();
          transaction.replace(R.id.fragmentContainerViewChat, chatFragment);
          transaction.addToBackStack(null);
          transaction.commit();
        });
      }
    });

    userRefListenerInitialized = true;
    amiciRefListenerInitialized = true;
  }

  void setPartecipanti() {
    chatRef.child(chatID).child("partecipanti").child(uid).setValue(displayname);
    chatRef.child(chatID).child("partecipanti").child(userIDOther).setValue(usernameOther);
  }

  void controllaChat(Iterator<DataSnapshot> listaChatIterator, String userId, bool chatTrovata, VoidCallback callback) {
    if (!listaChatIterator.moveNext()) {
      if (!chatTrovata) {
        final userOtherRef = FirebaseDatabase.instance.reference().child("users").child(userIDOther);
        final nuovaChatRef = userRef.child("chat").push();
        chatID = nuovaChatRef.key.toString();
        userOtherRef.child("chat").child(chatID).child("partecipante").child(uid).setValue(displayname);
        userRef.child("chat").child(chatID).child("partecipante").child(userIDOther).setValue(usernameOther);
        setPartecipanti();
      }
      callback();
      return;
    }

    final chat = listaChatIterator.current;

    if (chat.child("partecipante").hasChild(userId)) {
      chatID = chat.key.toString();
      controllaChat(listaChatIterator, userId, true, callback);
    } else {
      controllaChat(listaChatIterator, userId, chatTrovata, callback);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (userRefListenerInitialized) {
      userRef.off();
    }
    if (amiciRefListenerInitialized) {
      amiciRef.off();
    }
  }
}
