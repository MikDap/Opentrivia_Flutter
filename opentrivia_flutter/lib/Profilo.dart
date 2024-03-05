import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:opentrivia_flutter/main.dart';

class Profilo extends StatefulWidget {
  @override
  _ProfiloState createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {
  final databaseReference = FirebaseDatabase.instance.ref();
  late String uid;
  String nomeUtente = '';

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    userName(); // Richiama la funzione per recuperare il nome utente quando il widget viene creato
  }

  // Funzione per recuperare il nome utente dal database Firebase
  Future<void> userName() async {
    var usersRef = databaseReference.child('users').child(uid);
    final user = await usersRef.once();
    DataSnapshot leggiuser = user.snapshot;
    int randomNumber = generateRandomNumber();
    setState(() {
      if (leggiuser.hasChild('name')) {
        if (leggiuser.child('name').value != '' || leggiuser.child('name').value != null) {
          nomeUtente = leggiuser.child('name').value.toString();
          print('nomeutente: $nomeUtente');
        } else {
          nomeUtente = 'user$randomNumber';
          usersRef.child('name').set(nomeUtente);
        }
      } else {
        nomeUtente = 'user$randomNumber';
        usersRef.child('name').set(nomeUtente);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                // Dopo il logout, torna alla schermata di accesso o a un'altra schermata desiderata
                // Nell'esempio qui sotto, sto navigando indietro alla schermata di accesso
                Navigator.pushNamedAndRemoveUntil(context, '/sign in', (route) => false);
              }).catchError((e) {
                print(e); // Gestisci eventuali errori durante il logout
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F6AEC), Color(0xFF70B8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: nomeUtente.isNotEmpty
            ? Center(
          child: Text(
            'Benvenuto, $nomeUtente!',
            style: TextStyle(fontSize: 20),
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10000);
  }
}
