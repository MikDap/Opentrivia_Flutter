import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opentrivia_flutter/gioco/AttendiTurno.dart';
import 'package:opentrivia_flutter/utils/DatabaseUtils.dart';
import '../../api/ChiamataApi.dart';
import 'package:opentrivia_flutter/utils/GiocoUtils.dart';

class SceltaMultipla extends StatefulWidget {
  final String partita;
  final String difficulty;
  final String topic;
  final int contatoreRisposte;
  final int risposteCorrette;
  final int risposteSbagliate;
  final String nomeMateria;

  SceltaMultipla({
    required this.partita,
    required this.difficulty,
    required this.topic,
    required this.contatoreRisposte,
    required this.risposteCorrette,
    required this.risposteSbagliate,
    required this.nomeMateria,
  });

  @override
  _SceltaMultiplaState createState() => _SceltaMultiplaState();
}

class _SceltaMultiplaState extends State<SceltaMultipla>
    implements TriviaQuestionCallback {
  late FirebaseDatabase database;
  late DatabaseReference giocatoriRef;
  late DatabaseReference risposteRef;
  late Text domanda = const Text('');
  late Text risposta1 = const Text('');
  late Text risposta2 = const Text('');
  late Text risposta3 = const Text('');
  late Text risposta4 = const Text('');
  late String rispostaCorretta = '';
  bool rispostaData = false;
  late String uid;
  bool ritirato = false;
  bool avvRitirato = false;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
    uid = FirebaseAuth.instance.currentUser?.uid.toString() ?? "";
    giocatoriRef = database
        .ref()
        .child("partite")
        .child(widget.difficulty)
        .child(widget.partita)
        .child("giocatori");
    risposteRef = giocatoriRef.child(uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildUI();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> initData() async {
    await eseguiChiamataApi();
    await controllaRitiro();
  }

  Widget buildUI() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D2DF5), Color(0xFFF55702)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Materia: ${widget.nomeMateria}',
                      style: const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16.0), // Aggiungi spazio tra il primo e il secondo testo
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      'Corrette: ${widget.risposteCorrette}',
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text(
                      'Sbagliate: ${widget.risposteSbagliate}',
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: QuizCard(
                domanda: domanda,
                risposta1: risposta1,
                risposta2: risposta2,
                risposta3: risposta3,
                risposta4: risposta4,
                rispostaCorretta: rispostaCorretta,
                difficulty: widget.difficulty,
                topic: widget.topic,
                risposteRef: risposteRef,
                partita: widget.partita,
                contatoreRisposte: widget.contatoreRisposte,
                risposteCorrette: widget.risposteCorrette,
                risposteSbagliate: widget.risposteSbagliate,
                nomeMateria: widget.nomeMateria,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> controllaRitiro() async {
    // Implementa la logica per controllare il ritiro
  }

  Future<void> eseguiChiamataApi() async {
    var categoria = GiocoUtils().getCategoria(widget.topic);
    ChiamataApi chiamataApi =
    ChiamataApi("multiple", categoria, widget.difficulty);
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
    List<String> risposte = [
      rispostaCorretta,
      rispostaSbagliata1,
      rispostaSbagliata2,
      rispostaSbagliata3,
    ];
    risposte.shuffle();
    setState(() {
      this.domanda = Text(domanda);
      risposta1 = Text(risposte[0]);
      risposta2 = Text(risposte[1]);
      risposta3 = Text(risposte[2]);
      risposta4 = Text(risposte[3]);
      this.rispostaCorretta = rispostaCorretta;
    });
  }
}

class QuizCard extends StatefulWidget {
  final Text domanda;
  final Text risposta1;
  final Text risposta2;
  final Text risposta3;
  final Text risposta4;
  final String rispostaCorretta;
  double screenHeight = 0.0;
  final String difficulty;
  final String topic;
  final DatabaseReference risposteRef;
  final partita;
  int contatoreRisposte;
  int risposteCorrette;
  int risposteSbagliate;
  final String nomeMateria;

  QuizCard({
    required this.domanda,
    required this.risposta1,
    required this.risposta2,
    required this.risposta3,
    required this.risposta4,
    required this.rispostaCorretta,
    required this.difficulty,
    required this.topic,
    required this.risposteRef,
    required this.partita,
    required this.contatoreRisposte,
    required this.risposteCorrette,
    required this.risposteSbagliate,
    required this.nomeMateria,
  });

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  bool rispostaData = false;
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    widget.screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            height: widget.screenHeight * 0.16,
            child: Center(
              child: Text(
                widget.domanda.data ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: widget.screenHeight * 0.10),
          _buildAnswer(widget.risposta1),
          SizedBox(height: widget.screenHeight * 0.06),
          _buildAnswer(widget.risposta2),
          SizedBox(height: widget.screenHeight * 0.06),
          _buildAnswer(widget.risposta3),
          SizedBox(height: widget.screenHeight * 0.06),
          _buildAnswer(widget.risposta4),
          SizedBox(height: widget.screenHeight * 0.06),
        ],
      ),
    );
  }

  Widget _buildAnswer(Text answerText) {
    return ElevatedButton(
      onPressed: () async {
        if (!rispostaData) {
          setState(() {
            selectedAnswer = answerText.data ?? '';
            print('selectedAnswer: $selectedAnswer');
            if (GiocoUtils().questaELaRispostaCorretta(
                selectedAnswer, widget.rispostaCorretta)) {
              DatabaseUtils().updateRisposte(
                  widget.risposteRef, "risposteCorrette");
              widget.risposteCorrette++;
            } else {
              DatabaseUtils().updateRisposte(
                  widget.risposteRef, "risposteSbagliate");
              widget.risposteSbagliate++;
            }
          });
          widget.contatoreRisposte++;
          if (widget.contatoreRisposte <= 10) {
            await Future.delayed(const Duration(seconds: 4));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SceltaMultipla(
                  difficulty: widget.difficulty,
                  topic: widget.topic,
                  partita: widget.partita,
                  contatoreRisposte: widget.contatoreRisposte,
                  risposteCorrette: widget.risposteCorrette,
                  risposteSbagliate: widget.risposteSbagliate,
                  nomeMateria: widget.nomeMateria,
                ),
              ),
            );
          } else {
            finePartita(context);
          }
        }
        resetSelectedAnswer();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedAnswer.isNotEmpty && selectedAnswer == answerText.data
            ? (GiocoUtils().questaELaRispostaCorretta(
            selectedAnswer, widget.rispostaCorretta)
            ? Colors.green
            : Colors.red)
            : Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: Size.fromHeight(widget.screenHeight * 0.09),
      ),
      child: Text(
        answerText.data ?? '',
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  void resetSelectedAnswer() {
    setState(() {
      selectedAnswer = '';
    });
  }
}

void finePartita(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AttendiTurno()),
  );
}