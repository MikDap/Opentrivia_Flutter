import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';
import 'ModArgomentoSingolo.dart';

class SceltaMultiplaFragment extends StatefulWidget {
  @override
  _SceltaMultiplaFragmentArgSingoloState createState() =>
      _SceltaMultiplaFragmentArgSingoloState();
}

class _SceltaMultiplaFragmentArgSingoloState
    extends State<SceltaMultiplaFragment> {
  late FirebaseDatabase database;
  late DatabaseReference giocatoriRef;
  late DatabaseReference ritiratoRef;
  late DatabaseReference risposteRef;

  late Text domanda;
  late ElevatedButton risposta1;
  late ElevatedButton risposta2;
  late ElevatedButton risposta3;
  late ElevatedButton risposta4;

  //late ModArgomentoActivity modArgomentoActivity;

  late String rispostaCorretta;

  late String partita;
  late String modalita;
  late String difficolta;
  late String topic;

  bool rispostaData = false;
  late String uid;
  bool ritirato = false;
  bool avvRitirato = false;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
    uid = FirebaseAuth.instance.currentUser?.uid.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Sostituisci con la tua funzione asincrona per ottenere i dati
      future: initData(),
      builder: (context, snapshot) {
        if (snapshot == ConnectionState.done) {
          return buildUI();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> initData() async {
    // Inizializza i dati qui
    //modArgomentoActivity = context as ModArgomentoActivity;
    giocatoriRef = database
        .reference()
        .child("partite")
        .child(modalita)
        .child(difficolta)
        .child(partita);
    ritiratoRef = giocatoriRef.child(uid);
    risposteRef = giocatoriRef.child(uid).child(topic);

    await controllaRitiro();
  }

  Widget buildUI() {
    return Scaffold(
      body: Column(
        children: [
          // Includi qui i tuoi elementi UI
          domanda,
          risposta1,
          risposta2,
          risposta3,
          risposta4,
        ],
      ),
    );
  }

  Future<void> controllaRitiro() async {

  }

  void finePartita() async {

  }

  /*void controllaRisposta(ElevatedButton risposta) {
    if (!rispostaData) {
      if (GiocoUtils.QuestaèLaRispostaCorretta(risposta, rispostaCorretta)) {
    GiocoUtils.updateRisposte(risposteRef, "risposteCorrette");
    GiocoUtils.updateStatTopic(topic, "corretta");
    } else {
    GiocoUtils.updateRisposte(risposteRef, "risposteSbagliate");
    GiocoUtils.updateStatTopic(topic, "sbagliata");
    }

    modArgomentoActivity.contatoreRisposte++;
      if(modArgomentoActivity.risposta)
    modArgomentoActivity.getTriviaQuestion();
    } else {
    finePartita();
    }
    setState(() {
    rispostaData = true;
    });
  }
  }

  void onBackPressed() async {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Vuoi ritornare al menù?"),
      content: Text("ATTENZIONE: uscendo perderai la partita"),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ritiratoRef.child("ritirato").set("si");
            setState(() {
              ritirato = true;
            });
            finePartita();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          child: Text("SI"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("NO"),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }*/

}
