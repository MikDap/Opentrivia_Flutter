/* import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'SceltaMultiplaFragment.dart';

class ModArgomentoActivity extends StatefulWidget {
  get avversario => null;

  get sfidaAccettata => null;

  @override
  _ModArgomentoActivityState createState() => _ModArgomentoActivityState();
}

class _ModArgomentoActivityState extends State<ModArgomentoActivity>
    implements ArgomentoSingoloFragmentListener, TriviaQuestionCallback {
 late String partita;
  late String difficolta;
  late String avversario;
  late String avversarioNome;
  late String topic;
  late String categoria;
  late String sfidaAccettata;

  late ChiamataApi chiamataApi;
  late FirebaseDatabase database;

  String domanda = "";
  String rispostaCorretta = "";
  List<String> listaRisposte = [];

  int contatoreRisposte = 0;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aggiungi qui il codice del layout, se necessario
          ],
        ),
      ),
    );
  }

  @override
  void onVariablePassed(String topic) {
    setState(() {
      this.topic = topic;
    });

    // Chiamata alla funzione per ottenere il numero delle categorie per il topic selezionato
    categoria = GiocoUtils.getCategoria(topic);

    creaPartitaDatabase();

    // Fai la chiamata API
    chiamataApi = ChiamataApi("multiple", categoria, difficolta);
    chiamataApi.fetchTriviaQuestion(this);
  }

  @override
  void onTriviaQuestionFetched(String tipo, String domanda, String risposta_corretta,
      String risposta_sbagliata_1, String risposta_sbagliata_2, String risposta_sbagliata_3) {
    setState(() {
      this.domanda = chiamataApi.domanda;
      this.rispostaCorretta = chiamataApi.risposta_corretta;

      listaRisposte.clear();
      listaRisposte.addAll([risposta_corretta, risposta_sbagliata_1, risposta_sbagliata_2, risposta_sbagliata_3]);

      listaRisposte.shuffle();
    });

    // Passaggio al prossimo fragment SceltaMultiplaFragmentArgSingolo
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SceltaMultiplaFragment(
            partita: partita,
            modalita: "argomento singolo",
            difficolta: difficolta,
            topic: topic,
          ),
        ),
      );
    });
  }

  // Chiamata API per domanda e risposte
  void getTriviaQuestion() {
    chiamataApi = ChiamataApi("multiple", categoria, difficolta);
    chiamataApi.fetchTriviaQuestion(this);
  }

  // Se trova una partita associa l'utente, altrimenti crea una partita
  void creaPartitaDatabase() {
    DatabaseReference partiteRef = database.reference.child("partite").child("argomento singolo").child(difficolta);

    if (avversario == "casuale") {
      // Se posso, associo l'utente a una partita
      GiocoUtils.associaPartita("argomento singolo", difficolta, topic, (associato, partita) {
        if (associato) {
          setState(() {
            this.partita = partita;
          });
        } else {
          // Altrimenti, creo una partita
          GiocoUtils.creaPartita("argomento singolo", partiteRef, topic, (partita) {
            setState(() {
              this.partita = partita;
            });
          });
        }
      });
    } else {
      // Hai sfidato un amico
      GiocoUtils.sfidaAmico("argomento singolo", difficolta, topic, avversario, avversarioNome, (partita) {
        setState(() {
          this.partita = partita;
        });
      });
   }
  }
}*/
