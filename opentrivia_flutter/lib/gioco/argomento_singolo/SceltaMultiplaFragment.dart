import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:your_app/utils/gioco_utils.dart';

class SceltaMultiplaFragment extends StatefulWidget {
  @override
  _SceltaMultiplaFragmentArgSingoloState createState() =>
      _SceltaMultiplaFragmentArgSingoloState();
}

class _SceltaMultiplaFragmentArgSingoloState
    extends State<SceltaMultiplaFragmentArgSingolo> {
  late FirebaseDatabase database;
  late DatabaseReference giocatoriRef;
  late DatabaseReference ritiratoRef;
  late DatabaseReference risposteRef;

  late TextView domanda;
  late Button risposta1;
  late Button risposta2;
  late Button risposta3;
  late Button risposta4;

  late ModArgomentoActivity modArgomentoActivity;

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
        if (snapshot.connectionState == ConnectionState.done) {
          return buildUI();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> initData() async {
    // Inizializza i dati qui
    modArgomentoActivity = context as ModArgomentoActivity;
    giocatoriRef = database
        .reference()
        .child("partite")
        .child(modalita)
        .child(difficolta)
        .child(partita)
        .child("giocatori");
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
    try {
      DataSnapshot dataSnapshot = await giocatoriRef.once();
      dataSnapshot.value.forEach((giocatoreKey, giocatoreValue) {
        if (giocatoreValue['ritirato'] != null) {
          if (giocatoreKey != uid) {
            setState(() {
              avvRitirato = true;
            });
            finePartita();
          }
        }
      });
    } catch (error) {
      print(error.toString());
    }
  }

  void finePartita() async {
    if (modArgomentoActivity.avversario != "casuale" &&
        modArgomentoActivity.sfidaAccettata == "false") {
      DatabaseReference sfidaRef = database
          .reference()
          .child("users")
          .child(modArgomentoActivity.avversario)
          .child("sfide")
          .child(partita);
      sfidaRef.child("fineTurno").set("si");
    }

    await GiocoUtils.getAvversario(modalita, difficolta, partita,
            (giocatore2esiste, avversario, nomeAvv) async {
          await GiocoUtils.getRispCorrette(
              modalita, difficolta, partita, (risposte1, risposte2) async {
            if (ritirato) {
              await giocatoriRef.child(uid).child("fineTurno").set("si");
              if (!giocatore2esiste) {
                await GiocoUtils.spostaInPartiteTerminate(
                    partita, modalita, difficolta, uid, risposte1, risposte2);
              }
            } else if (avvRitirato) {
              await giocatoriRef.child(uid).child("fineTurno").set("si");
              await GiocoUtils.spostaInPartiteTerminate(
                  partita, modalita, difficolta, uid, risposte1, risposte2);
              await GiocoUtils.spostaInPartiteTerminate(
                  partita, modalita, difficolta, avversario, risposte1, risposte2);
              await GiocoUtils.schermataVittoria(
                  context, R.id.fragmentContainerViewGioco2, nomeAvv, risposte1,
                  risposte2, "argomento singolo");
            } else {
              if (!giocatore2esiste) {
                await giocatoriRef.child(uid).child("fineTurno").set("si");
                await GiocoUtils.schermataAttendi(
                    context, R.id.fragmentContainerViewGioco2);
              } else {
                await giocatoriRef.child(uid).child("fineTurno").set("si");
                await GiocoUtils.spostaInPartiteTerminate(
                    partita, modalita, difficolta, uid, risposte1, risposte2);
                await GiocoUtils.spostaInPartiteTerminate(
                    partita, modalita, difficolta, avversario, risposte1, risposte2);

                switch (risposte1.compareTo(risposte2)) {
                  case 1:
                    await GiocoUtils.schermataVittoria(
                        context, R.id.fragmentContainerViewGioco2, nomeAvv,
                        risposte1, risposte2, "argomento singolo");
                    break;
                  case 0:
                    await GiocoUtils.schermataPareggio(
                        context, R.id.fragmentContainerViewGioco2, nomeAvv,
                        risposte1, risposte2, "argomento singolo");
                    break;
                  case -1:
                    await GiocoUtils.schermataSconfitta(
                        context, R.id.fragmentContainerViewGioco2, nomeAvv,
                        risposte1, risposte2, "argomento singolo");
                    break;
                }
              }
            }
          });
        });
  }

  void controllaRisposta(Button risposta) {
    if (!rispostaData) {
      if (GiocoUtils.QuestaèLaRispostaCorretta(risposta, rispostaCorretta)) {
    GiocoUtils.updateRisposte(risposteRef, "risposteCorrette");
    GiocoUtils.updateStatTopic(topic, "corretta");
    } else {
    GiocoUtils.updateRisposte(risposteRef, "risposteSbagliate");
    GiocoUtils.updateStatTopic(topic, "sbagliata");
    }

    modArgomentoActivity.contatoreRisposte++;
    if (modArgomentoActivity.contatoreRisposte < 10) {
    modArgomentoActivity.getTriviaQuestion();
    } else {
    finePartita();
    }
    setState(() {
    rispostaData = true;
    });
  }
  }

  void onBackPressed() {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Vuoi ritornare al menù?"),
      message: Text("ATTENZIONE: uscendo perderai la partita"),
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
              MaterialPageRoute(builder: (context) => MainActivity()),
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
  }
}
