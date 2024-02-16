import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';
import 'package:opentrivia_flutter/utils/DatabaseUtils.dart';
import '../../api/ChiamataApi.dart';
import 'package:opentrivia_flutter/utils/GiocoUtils.dart';

class SceltaMultipla extends StatefulWidget {
  late final String partita;
  final String difficulty;
  final String topic;
  final String nomeMateria;
  final int contatoreRisposte;
  final int risposteCorrette;
  final int risposteSbagliate;
  bool apiEseguita = false;

//bool avvRitirato = false;
  SceltaMultipla({
    required this.partita,
    required this.difficulty,
    required this.topic,
    required this.contatoreRisposte,
    required this.nomeMateria,
    required this.risposteCorrette,
    required this.risposteSbagliate,
    required this.apiEseguita,
  });
  @override
  _SceltaMultiplaState createState() => _SceltaMultiplaState();
}

class _SceltaMultiplaState extends State<SceltaMultipla>
    implements TriviaQuestionCallback {
  late FirebaseDatabase database;
  late DatabaseReference giocatoriRef;
  late DatabaseReference ritiratoRef;
  late DatabaseReference risposteRef;
  late Text domanda = Text('');
  late Text risposta1 = Text('');
  late Text risposta2 = Text('');
  late Text risposta3 = Text('');
  late Text risposta4 = Text('');
  late String rispostaCorretta = '';
  late String uid;
  bool ritirato = false;
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
    ritiratoRef = giocatoriRef.child(uid);
    risposteRef = giocatoriRef.child(uid);
    eseguiChiamataApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
// Sostituisci con la tua funzione asincrona per ottenere i dati
      future: initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('snapshot.connectionState == ConnectionState.done');
          while (widget.apiEseguita == false){
            print('entrawhile');
            return Center(
                child: CircularProgressIndicator(strokeWidth: 10,)
            );
          }
          return buildUI();
        }
        print('CircularProgressIndicator()');
        return Center(
            child: CircularProgressIndicator(strokeWidth: 10,)
        );
      },
    );
  }

  Future<void> initData() async {
    super.initState();
    giocatoriRef = database.ref().child("partite").child(widget.difficulty).child(widget.partita);
    ritiratoRef = giocatoriRef.child(uid);
    risposteRef = giocatoriRef.child(uid).child(widget.topic);
    await creaPartitaDatabase();
//await controllaRitiro();
  }

  Widget buildUI() {
    print('domanda,$domanda');
      print('domanda.data != null && domanda.data!.isNotEmpty');
      return WillPopScope(
        onWillPop: () async {
// Handle back button press here
          await onBackPressed(ritiratoRef, giocatoriRef);
          return false; // Return false to prevent default behavior
        },
        child: Scaffold(
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
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16.0),
// Aggiungi spazio tra il primo e il secondo testo
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          'Corrette: ${widget.risposteCorrette}',
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          'Sbagliate: ${widget.risposteSbagliate}',
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
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
                    uid: uid,
                    giocatoriRef: giocatoriRef,
                    ritiratoRef: ritiratoRef,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

// Altri metodi come finePartita, controllaRisposta, onBackPressed possono essere implementati qui
  Future<void> eseguiChiamataApi() async {
    print('entraaa');
    var categoria = GiocoUtils().getCategoria(widget.topic);
    print('categoria,$categoria');
// Creare un'istanza di ChiamataApi
    ChiamataApi chiamataApi =
        ChiamataApi("multiple", categoria, widget.difficulty);
// Chiamare il metodo fetchTriviaQuestion passando l'istanza corrente
    chiamataApi.fetchTriviaQuestion(this);
  }

  Future<void> creaPartitaDatabase() async {
    DatabaseReference partiteRef = FirebaseDatabase.instance
        .ref()
        .child("partite")
        .child(widget.difficulty);
    DatabaseUtils databaseUtils = DatabaseUtils();
// SE POSSO ASSOCIO L'UTENTE A UNA PARTITA
    String top = widget.topic;
    String top1 = widget.difficulty;
    String top2 = widget.partita;
    print('widget.topic,$top');
    print('widget.difficulty,' + '$top1');
    print('widget.partita,$top2');
    databaseUtils.associaPartita(widget.difficulty, widget.topic,
        (associato, partita) {
      if (associato) {
        this.widget.partita = partita;
      }
// ALTRIMENTI CREO UNA PARTITA
      else {
        databaseUtils.creaPartita(partiteRef, widget.topic, (partita) {
          this.widget.partita = partita;
        });
      }
    });
  }

/*Future <void> controllaRitiro(DatabaseReference giocatoriRef) async {
final giocatori= await giocatoriRef.once();
DataSnapshot listagiocatori =giocatori.snapshot;
if (listagiocatori.children.isNotEmpty) {
for (final giocatore in listagiocatori.children) {
var giocatore1=giocatore.key.toString();
if(giocatore.hasChild("ritirato") != null && giocatore1 != uid){
widget.avvRitirato=true;
await finePartita(giocatoriRef,uid);
}
}
}}*/
  Future<void> fineRitiro() async {
    await DatabaseUtils().getAvversario(widget.difficulty, widget.partita,
        (giocatore2esiste, avversario, nomeAvv) async {
      await DatabaseUtils().getRispCorrette(widget.difficulty, widget.partita,
          (risposte1, risposte2) async {
        if (ritirato) {
          giocatoriRef.child(uid).child("fineTurno").set("si");
          if (!giocatore2esiste) {
            DatabaseUtils().spostaInPartiteTerminate(
                widget.partita, widget.difficulty, uid, risposte1, risposte2);
          } else {
            DatabaseUtils().spostaInPartiteTerminate(
                widget.partita, widget.difficulty, uid, risposte1, risposte2);
            DatabaseUtils().spostaInPartiteTerminate(widget.partita,
                widget.difficulty, avversario, risposte1, risposte2);
          }
        }
/*else {
          if (!giocatore2esiste) {
            giocatoriRef.child(uid).child("fineTurno").set("si");
            GiocoUtils().schermataAttendi(context, risposte1);
          }
          else {
            giocatoriRef.child(uid).child("fineTurno").set("si");
            DatabaseUtils().spostaInPartiteTerminate(widget.partita,widget.difficulty, uid, risposte1, risposte2);
            DatabaseUtils().spostaInPartiteTerminate(widget.partita,widget.difficulty, avversario, risposte1, risposte2);
            switch (risposte1.compareTo(risposte2)) {
              case 0:
                GiocoUtils().schermataPareggio(context, nomeAvv, risposte1, risposte2);
                break;
              case 1:
                GiocoUtils().schermataVittoria(context, nomeAvv, risposte1, risposte2);
                break;
              case -1:
                GiocoUtils().schermataSconfitta(context, nomeAvv, risposte1, risposte2);
                break;
              default:
// Handle any other case if needed
                break;
            }
          }
        } */
      });
    });
  }

  Future<void> onBackPressed(
      DatabaseReference ritiratoRef, DatabaseReference giocatoriRef) async {
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
            fineRitiro();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Menu()),
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

  @override
  void onTriviaQuestionFetched(
    String tipo,
    String domanda,
    String rispostaCorretta,
    String rispostaSbagliata1,
    String rispostaSbagliata2,
    String rispostaSbagliata3,
  ) {
/*print('domanda : $domanda');
if (domanda == null || rispostaCorretta == null || rispostaSbagliata1 == null || rispostaSbagliata2 == null || rispostaSbagliata3 == null) {
print('DOMANDA NULL');// Se una delle risposte è nulla, richiama nuovamente la chiamata API
eseguiChiamataApi();
return;
}*/
// Creare una lista contenente tutte le risposte
    List<String> risposte = [
      rispostaCorretta,
      rispostaSbagliata1,
      rispostaSbagliata2,
      rispostaSbagliata3,
    ];
// Mescolare la lista in modo casuale
    risposte.shuffle();
    print("domanda:,$domanda");
// Assegnare le risposte mescolate alle variabili
      setState(() {
        this.domanda = Text(domanda);
        risposta1 = Text(risposte[0]);
        risposta2 = Text(risposte[1]);
        risposta3 = Text(risposte[2]);
        risposta4 = Text(risposte[3]);
        this.rispostaCorretta = rispostaCorretta;
      });
      widget.apiEseguita = true;
  }
}

class QuizCard extends StatefulWidget {
  final Text domanda;
  final Text risposta1;
  final Text risposta2;
  final Text risposta3;
  final Text risposta4;
  bool rispostaData = false;
  final String rispostaCorretta;
  double screenHeight = 0.0;
  final String difficulty;
  final String topic;
  final DatabaseReference risposteRef;
  final partita;
  int contatoreRisposte;
  int risposteCorrette;
  int risposteSbagliate;
  final String uid;
  final String nomeMateria;
  final DatabaseReference giocatoriRef;
  final DatabaseReference ritiratoRef;
//bool avvRitirato=false;
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
    required this.giocatoriRef,
    required this.ritiratoRef,
    required this.uid,
    required this.risposteCorrette,
    required this.risposteSbagliate,
    required this.nomeMateria,
  });
  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String partita = '';
  String selectedAnswer = '';
  bool ritirato = false;
  @override
  Widget build(BuildContext context) {
    widget.screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
// Domanda in cima
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
          SizedBox(height: widget.screenHeight * 0.06),
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
        if (!widget.rispostaData) {
          setState(() {
            widget.rispostaData = true;
            selectedAnswer = answerText.data ?? '';
            print('selectedAnswer: $selectedAnswer');
            if (GiocoUtils().questaELaRispostaCorretta(
                selectedAnswer, widget.rispostaCorretta)) {
// Logica per risposta corretta
              DatabaseUtils()
                  .updateRisposte(widget.risposteRef, "risposteCorrette");
              widget.risposteCorrette++;
            } else {
// Logica per risposta sbagliata
              DatabaseUtils()
                  .updateRisposte(widget.risposteRef, "risposteSbagliate");
              widget.risposteSbagliate++;
            }
          });
          widget.contatoreRisposte++;
          if (widget.contatoreRisposte <= 9) {
            await Future.delayed(Duration(seconds: 4));
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
                  apiEseguita: false,
                ),
              ),
            );
          } else {
            await Future.delayed(Duration(seconds: 4));
            await finePartita();
          }
          resetSelectedAnswer();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedAnswer.isNotEmpty && selectedAnswer == answerText.data
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

/*Future <void> controllaRitiro(DatabaseReference giocatoriRef) async {
final giocatori= await giocatoriRef.once();
DataSnapshot listagiocatori =giocatori.snapshot;
if (listagiocatori.children.isNotEmpty) {
for (final giocatore in listagiocatori.children) {
var giocatore1=giocatore.key.toString();
if(giocatore.hasChild("ritirato") != null && giocatore1 != widget.uid){
widget.avvRitirato=true;
await finePartita(giocatoriRef,widget.uid);
}
}
}}*/
  Future<void> finePartita() async {
    print("finepartita2");
    await DatabaseUtils().getAvversario(widget.difficulty, widget.partita,
        (giocatore2esiste, avversario, nomeAvv) async {
      await DatabaseUtils().getRispCorrette(widget.difficulty, widget.partita,
          (risposte1, risposte2) async {
/*if (ritirato) {
        widget.giocatoriRef.child(widget.uid).child("fineTurno").set("si");
        if (!giocatore2esiste) {
          DatabaseUtils().spostaInPartiteTerminate(widget.partita,widget.difficulty,widget.uid, risposte1, risposte2);
        }
        else{
          DatabaseUtils().spostaInPartiteTerminate(widget.partita,widget.difficulty, widget.uid, risposte1, risposte2);
          DatabaseUtils().spostaInPartiteTerminate(widget.partita,widget.difficulty, avversario, risposte1, risposte2);
        } }
      else {*/
        if (!giocatore2esiste) {
          widget.giocatoriRef.child(widget.uid).child("fineTurno").set("si");
          GiocoUtils().schermataAttendi(context, risposte1);
        } else {
          widget.giocatoriRef.child(widget.uid).child("fineTurno").set("si");
          DatabaseUtils().spostaInPartiteTerminate(widget.partita,
              widget.difficulty, widget.uid, risposte1, risposte2);
          DatabaseUtils().spostaInPartiteTerminate(widget.partita,
              widget.difficulty, avversario, risposte1, risposte2);
          switch (risposte1.compareTo(risposte2)) {
            case 0:
              GiocoUtils()
                  .schermataPareggio(context, nomeAvv, risposte1, risposte2);
              break;
            case 1:
              GiocoUtils()
                  .schermataVittoria(context, nomeAvv, risposte1, risposte2);
              break;
            case -1:
              GiocoUtils()
                  .schermataSconfitta(context, nomeAvv, risposte1, risposte2);
              break;
            default:
// Handle any other case if needed
              break;
          }
        }
//}
      });
    });
  }
}
