import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';
import '../../api/ChiamataApi.dart';
import 'ModArgomentoSingolo.dart';

class SceltaMultipla extends StatefulWidget {
  final String difficulty;
  final String topic;

  SceltaMultipla({required this.difficulty, required this.topic});

  @override
  _SceltaMultiplaState createState() => _SceltaMultiplaState();
}

class _SceltaMultiplaState extends State<SceltaMultipla> implements TriviaQuestionCallback {
  late FirebaseDatabase database;
  late DatabaseReference giocatoriRef;
  late DatabaseReference ritiratoRef;
  late DatabaseReference risposteRef;

  late Text domanda = Text('');
  late Text risposta1 = Text('');
  late Text risposta2 = Text('');
  late Text risposta3 = Text('');
  late Text risposta4 = Text('');

  late Text rispostaCorretta;

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
   // giocatoriRef = database.ref().child("partite").child(difficolta).child(partita);
  //  ritiratoRef = giocatoriRef.child(uid);
   // risposteRef = giocatoriRef.child(uid).child(topic);
    await eseguiChiamataApi();
    await controllaRitiro();
  }

  Widget buildUI() {
    return Scaffold(
      body: Column(
        children: [
          QuizCard(domanda: domanda,risposta1: risposta1,risposta2: risposta2,risposta3: risposta3, risposta4: risposta4), // Aggiungi QuizCard come parte della UI di SceltaMultipla
          // Altri elementi UI possono essere aggiunti qui
        ],
      ),
    );
  }

  Future<void> controllaRitiro() async {
    // Implementa la logica per controllare il ritiro
  }

// Altri metodi come finePartita, controllaRisposta, onBackPressed possono essere implementati qui
  Future<void> eseguiChiamataApi() async {
    // Creare un'istanza di ChiamataApi
    ChiamataApi chiamataApi = ChiamataApi("multiple", "23", "easy");

    // Chiamare il metodo fetchTriviaQuestion passando l'istanza corrente
    chiamataApi.fetchTriviaQuestion(this);
  }

  @override
  void onTriviaQuestionFetched(
      String tipo,
      String domanda,
      String rispostaCorretta,
      String rispostaSbagliata1,
      String rispostaSbagliata2,
      String rispostaSbagliata3,
      ) {
    // Creare una lista contenente tutte le risposte
    List<String> risposte = [
      rispostaCorretta,
      rispostaSbagliata1,
      rispostaSbagliata2,
      rispostaSbagliata3,
    ];

    // Mescolare la lista in modo casuale
    risposte.shuffle();

    // Assegnare le risposte mescolate alle variabili
    setState(() {
      this.domanda = Text(domanda);
      risposta1 = Text(risposte[0]);
      risposta2 = Text(risposte[1]);
      risposta3 = Text(risposte[2]);
      risposta4 = Text(risposte[3]);
    });
  }
}

class QuizCard extends StatelessWidget {
  final Text domanda;
  final Text risposta1;
  final Text risposta2;
  final Text risposta3;
  final Text risposta4;
  double screenHeight = 0.0;

  QuizCard({
    required this.domanda,
    required this.risposta1,
    required this.risposta2,
    required this.risposta3,
    required this.risposta4,
  });
  @override
  Widget build(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;

  return Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
  // Domanda in cima
  Container(
  decoration: BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.circular(8), // Imposta il bordo arrotondato
  ),
  height:screenHeight * 0.14,

  child: Text(
    domanda.data ?? '',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  ),
  SizedBox(height: screenHeight * 0.09), // Utilizzo di MediaQuery per adattare la dimensione
    _buildAnswer(risposta1),
  SizedBox(height: screenHeight * 0.09), // Spazio verticale tra gli oggetti AnswerOption
    _buildAnswer(risposta2),
  SizedBox(height: screenHeight * 0.09),
    _buildAnswer(risposta3),
  SizedBox(height: screenHeight * 0.09),
    _buildAnswer(risposta4),
  SizedBox(height: screenHeight * 0.09),
  ],
  ),
  );
  }

  Widget _buildAnswer(Text answerText) {
  return ElevatedButton(
  onPressed: () {
  // Aggiungi qui la logica per gestire la risposta selezionata
  },
  style: ElevatedButton.styleFrom(
  primary: Colors.blue,
  onPrimary: Colors.white,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(8),
  ),
  fixedSize: Size.fromHeight(screenHeight * 0.09),
  ),
  child: Text(
    answerText.data ?? '',
    style: TextStyle(fontSize: 16.0),
  ),
  );
  }
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

