import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Utente {
  final String id;
  final String name;

  Utente(this.id, this.name);
}

class ListaUtenti extends StatefulWidget {
  @override
  _ListaUtentiState createState() => _ListaUtentiState();
}

class _ListaUtentiState extends State<ListaUtenti> {
  late List<Utente> listaUtenti;
  late String uid;
  late DatabaseReference usersRef;

  @override
  void initState() {
    super.initState();
    listaUtenti = [];
    uid = FirebaseAuth.instance.currentUser!.uid;
    usersRef = FirebaseDatabase.instance.ref().child('users');

    _caricaUtenti();
  }

  Future<void> _caricaUtenti() async {
    try {
      final users = await usersRef.once();
      DataSnapshot listaUsers = users.snapshot;

      if (listaUsers.exists) {
        Map<dynamic, dynamic>? usersMap = listaUsers.value as Map<dynamic, dynamic>?;

        if (usersMap != null) {
          usersMap.forEach((key, value) {
            Utente utente = Utente(key, value['name']);
            if (utente.id != uid) {
              setState(() {
                listaUtenti.add(utente);
              });
            }
          });
        }
      }
    } catch (error) {
      print("Errore durante il recupero degli utenti: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Utenti'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F6AEC), Color(0xFF70B8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: listaUtenti.length,
          itemBuilder: (context, position) {
            var utente = listaUtenti[position];
            if (utente.id != uid) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.all(2),
                child: ListTile(
                  title: Text(
                    utente.name,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'ID: ${utente.id}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
