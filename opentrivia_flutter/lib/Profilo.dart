import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
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
    _fetchUserName(); // Chiamata per recuperare il nome utente iniziale
  }

  void _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        nomeUtente = user.displayName ?? ''; // Aggiorna il nome utente se disponibile
      });
    }
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
                Navigator.pushNamedAndRemoveUntil(context, '/sign in', (route) => false);
              }).catchError((e) {
                print(e);
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/saluto.json",
                  repeat: true,
                  width: 250,
                  height: 250,
                ),
                SizedBox(height: 20), // Spazio tra l'animazione e il testo
                if (nomeUtente.isNotEmpty) // Mostra il messaggio di benvenuto solo se il nome utente è disponibile
                  Text(
                    'Benvenuto, $nomeUtente!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Cambia il colore del testo
                      fontStyle: FontStyle.italic, // Aggiungi stile corsivo
                      // Altre proprietà di stile come fontFamily, letterSpacing, etc.
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10000);
  }
}
