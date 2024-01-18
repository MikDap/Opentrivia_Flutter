import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseUtils {

  static final FirebaseDatabase database = FirebaseDatabase.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> associaPartita(String difficolta, String topic, Function(bool, String) callback) async {
    String? uid = user?.uid;
    String? name = user?.displayName;

    DatabaseReference partiteRef = database.ref().child("partite").child(difficolta);

   final partite = await partiteRef.once(DatabaseEventType.value);
   final listaPartite = partite.snapshot;
      bool associato = false;
      String partita = "nessuna";

      if (listaPartite.children.isNotEmpty) {
        for (final partita1 in listaPartite.children) {

            bool giocatoreDiverso = true;
            String idAvversario = "-";

            for(final giocatore in partita1.child("giocatori").children) {
              if (giocatore.key.toString() == uid) {
                giocatoreDiverso = false;
              } else {
                idAvversario = giocatore.key.toString();
              }
            }

            bool haFinitoTurno = false;

            if (giocatoreDiverso && partita1.child("giocatori").child(idAvversario).hasChild("fineTurno")){
              haFinitoTurno = true;
            }

            if (partita1.child("inAttesa").value == "si" && partita1.hasChild("topic") && giocatoreDiverso && haFinitoTurno) {
              if (partita1.child("topic").value == topic) {
                //prende id della partita
                partita = partita1.key.toString();
                //setta database/partite/modalita/difficolta/giocatori/id
                partiteRef.child(partita).child("giocatori").child(uid!).set({
                  "name": name
                });
                //cambia inAttesa in no
                partiteRef.child(partita).set({
                  "inAttesa": "no"
                });
                associato = true;
                break;
              }
            }
        }
      }
      callback(associato, partita);
  }




  void creaPartita(DatabaseReference partiteRef,String topic, Function(String) callback){

    String? uid = user?.uid;
    String? name = user?.displayName;
    String partita = partiteRef.push().key.toString();
    String inAttesa = "si";

  partiteRef.child(partita).set({
    "inAttesa": inAttesa
  });

  partiteRef.child(partita).set({
    "topic": topic
  });


  partiteRef.child(partita).child("giocatori").child(uid!).set({
    "name": name
  });
  callback(partita);
  }

}
