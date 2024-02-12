import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//ci siamo
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
      // Ottieni la lista degli utenti dal database Firebase
      final users = await usersRef.once();
      DataSnapshot listaUsers = users.snapshot;

      // Verifica se ci sono dati nell'elenco degli utenti
      if (listaUsers.exists) {
        // Converte il valore in un tipo Map
        Map<dynamic, dynamic>? usersMap = listaUsers.value as Map<dynamic, dynamic>?;

        // Verifica se usersMap non è nullo
        if (usersMap != null) {
          // Itera su ogni utente nel DataSnapshot
          usersMap.forEach((key, value) {
            // Crea un nuovo oggetto Utente e aggiungilo alla lista
            Utente utente = Utente(key, value['name']);
            // Aggiungi l'utente alla listaUtenti solo se l'ID non corrisponde all'ID dell'utente corrente
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
        title:const  Text('LISTA UTENTI'),
      ),
      body: ListView.builder(
        itemCount: listaUtenti.length,
        itemBuilder: (context, position) {
          var utente = listaUtenti[position];
          if (utente.id != uid) {
            return ListTile(
              title: Text(
                utente.name,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'ID: ${utente.id}',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
