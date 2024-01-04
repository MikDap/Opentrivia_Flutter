import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AggiungiAmico extends StatefulWidget {
  @override
  _AggiungiAmicoState createState() => _AggiungiAmicoState();
}

class _AggiungiAmicoState extends State<AggiungiAmico> {
  late FirebaseDatabase database;
  late TextEditingController editTextController;
  late Button buttonSearchFriend;
  late RecyclerView recyclerView;

  final userKeyMap = <String, String>{};
  late UsersAdapter adapter;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
    editTextController = TextEditingController();
    buttonSearchFriend = Button(child: Text('Cerca amico'), onPressed: searchFriend);
    recyclerView = RecyclerView();

    adapter = UsersAdapter(userKeyMap);

    recyclerView.setAdapter(adapter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aggiungi Amico'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: editTextController,
              decoration: InputDecoration(labelText: 'Nome amico'),
            ),
            ElevatedButton(
              onPressed: searchFriend,
              child: Text('Cerca amico'),
            ),
            Expanded(
              child: recyclerView,
            ),
          ],
        ),
      ),
    );
  }

  void searchFriend() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final usersRef = database.reference().child("users");

    userKeyMap.clear();

    usersRef.once().then((DataSnapshot snapshot) {
      snapshot.value.forEach((userId, userData) {
        final username = userData["username"] as String?;

        if (userId != uid && userId != null && username != null &&
            username.toLowerCase().contains(editTextController.text.toLowerCase())) {
          userKeyMap[userId] = username;
        }
      });

      setState(() {
        adapter.notifyDataSetChanged();
      });
    });
  }
}
