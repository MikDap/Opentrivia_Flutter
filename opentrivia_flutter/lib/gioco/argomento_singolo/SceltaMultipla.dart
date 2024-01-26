import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';
import 'package:opentrivia_flutter/utils/DatabaseUtils.dart';
import '../../api/ChiamataApi.dart';
import 'ModArgomentoSingolo.dart';
import 'package:opentrivia_flutter/utils/GiocoUtils.dart';
class SceltaMultipla extends StatefulWidget {
final String partita;
final String difficulty;
final String topic;
final int contatoreRisposte;
SceltaMultipla({required this.partita,required this.difficulty, required this.topic, required this.contatoreRisposte});
@override
_SceltaMultiplaState createState() => _SceltaMultiplaState();
}
class _SceltaMultiplaState extends State<SceltaMultipla> implements TriviaQuestionCallback {
late FirebaseDatabase database;
late DatabaseReference giocatoriRef;
late DatabaseReference risposteRef;
late Text domanda = Text('');
late Text risposta1 = Text('');
late Text risposta2 = Text('');
late Text risposta3 = Text('');
late Text risposta4 = Text('');
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
giocatoriRef = database.ref().child("partite").child(widget.difficulty).child(widget.partita).child("giocatori");
risposteRef = giocatoriRef.child(uid);
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
  super.initState();
 giocatoriRef = database.ref().child("partite").child(widget.difficulty).child(widget.partita);
  //ritiratoRef = giocatoriRef.child(uid);
 risposteRef = giocatoriRef.child(uid).child(widget.topic);
await eseguiChiamataApi();
await controllaRitiro();

}
Widget buildUI() {
  if (domanda!=null || risposta1!=null || risposta2!=null ||
      risposta3!=null || risposta4!=null || rispostaCorretta.isNotEmpty) {
    // Tutte le variabili sono popolate, costruisci il widget QuizCard
    return Scaffold(
      body: Column(
        children: [
          QuizCard(
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
            giocatoriRef:giocatoriRef ,
            uid: uid,
          ),
          // Altri elementi UI possono essere aggiunti qui
        ],
      ),
    );
  }
  else {
    return Center(
        child: CircularProgressIndicator(
      strokeWidth:10 ,
    )
        );
  }
}



Future<void> controllaRitiro() async {
// Implementa la logica per controllare il ritiro
}
// Altri metodi come finePartita, controllaRisposta, onBackPressed possono essere implementati qui
Future<void> eseguiChiamataApi() async {
var categoria = GiocoUtils().getCategoria(widget.topic);
// Creare un'istanza di ChiamataApi
ChiamataApi chiamataApi = ChiamataApi("multiple", categoria, widget.difficulty);
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
//print('domanda : $domanda');
//if (domanda == null || rispostaCorretta == null || rispostaSbagliata1 == null || rispostaSbagliata2 == null || rispostaSbagliata3 == null) {
//print('DOMANDA NULL');// Se una delle risposte è nulla, richiama nuovamente la chiamata API
//eseguiChiamataApi();
//return;
//}
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
String rispostaCorretta;
double screenHeight = 0.0;
final String difficulty;
final String topic;
final DatabaseReference risposteRef;
final partita;
int contatoreRisposte;
final String uid;
final DatabaseReference giocatoriRef;
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
  required this.uid,
});
@override
_QuizCardState createState() => _QuizCardState();
}
class _QuizCardState extends State<QuizCard> {
  String partita = '';
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
// Domanda in cima
Container(
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(8),
),
height: widget.screenHeight * 0.14,
child: Text(
widget.domanda.data ?? '',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
),
SizedBox(height: widget.screenHeight * 0.09),
_buildAnswer(widget.risposta1),
SizedBox(height: widget.screenHeight * 0.09),
_buildAnswer(widget.risposta2),
SizedBox(height: widget.screenHeight * 0.09),
_buildAnswer(widget.risposta3),
SizedBox(height: widget.screenHeight * 0.09),
_buildAnswer(widget.risposta4),
SizedBox(height: widget.screenHeight * 0.09),
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
if (GiocoUtils().questaELaRispostaCorretta(selectedAnswer, widget.rispostaCorretta)) {
// Logica per risposta corretta
DatabaseUtils().updateRisposte(widget.risposteRef, "risposteCorrette");
} else {
// Logica per risposta sbagliata
DatabaseUtils().updateRisposte(widget.risposteRef, "risposteSbagliate");
}
});
widget.contatoreRisposte++;
if (widget.contatoreRisposte != 10) {
await Future.delayed(Duration(seconds: 3));
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => SceltaMultipla(
difficulty: widget.difficulty,
topic: widget.topic,
partita: widget.partita,
contatoreRisposte: widget.contatoreRisposte,
),
),
);
} else { String ciao= widget.uid.toString();
  print('ciao:$ciao');
finePartita(widget.giocatoriRef,widget.uid);
}
}
resetSelectedAnswer(); },
style: ElevatedButton.styleFrom(
primary: selectedAnswer.isNotEmpty && selectedAnswer == answerText.data
? (GiocoUtils().questaELaRispostaCorretta(selectedAnswer, widget.rispostaCorretta) ? Colors.green : Colors.red)
    : Colors.blue,
onPrimary: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
fixedSize: Size.fromHeight(widget.screenHeight * 0.09),
),
child: Text(
answerText.data ?? '',
style: TextStyle(fontSize: 16.0),
),
);
}

void resetSelectedAnswer() {
setState(() {
selectedAnswer = '';
});
}


Future<void> controllaRitiro() async {
}

Future<void> finePartita(DatabaseReference giocatoriRef,String uid ) async {

  await DatabaseUtils().getAvversario(widget.difficulty, widget.partita, (giocatore2esiste, avversario, nomeAvv) async {
    print("Giocatore 2 esiste: $giocatore2esiste");
    print("Avversario: $avversario");
    print("Nome avversario: $nomeAvv");

    await DatabaseUtils().getRispCorrette(widget.difficulty, widget.partita, (risposte1, risposte2) async {
      // Uncomment and modify the logic based on your requirements
      /*
      if (ritirato) {
        if (!giocatore2esiste) {
          GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, uid, risposte1, risposte2);
        }
      } else if (avvRitirato) {
        giocatoriRef.child(uid).child("fineTurno").setValue("si");

        GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, uid, risposte1, risposte2);
        GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, avversario, risposte1, risposte2);

        GiocoUtils.schermataVittoria(requireActivity().supportFragmentManager, R.id.fragmentContainerViewGioco2, nomeAvv, risposte1, risposte2, "argomento singolo");
      } else {*/
        if (!giocatore2esiste) {print('risposte1,$risposte1');
        print('risposte1,$risposte2');
          giocatoriRef.child(uid).child("fineTurno").set("si");
          GiocoUtils().schermataAttendi(context);
              //requireActivity().supportFragmentManager, R.id.fragmentContainerViewGioco2);
        }
        else {print('risposte1,$risposte1');
      print('risposte1,$risposte2');/*
          giocatoriRef.child(uid).child("fineTurno").setValue("si");
          GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, uid, risposte1, risposte2);
          GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, avversario, risposte1, risposte2);
*/
          if (risposte1 > risposte2) {
            // Use your actual schermataVittoria logic here
            GiocoUtils().schermataVittoria(context);
          } else if (risposte1 == risposte2) {
            GiocoUtils().schermataPareggio(context);
                //requireActivity().supportFragmentManager, R.id.fragmentContainerViewGioco2, nomeAvv, risposte1, risposte2, "argomento singolo");
          }else {
            GiocoUtils().schermataSconfitta(context);
                //requireActivity().supportFragmentManager, R.id.fragmentContainerViewGioco2, nomeAvv, risposte1, risposte2, "argomento singolo");
          }
        }
        });
  });
}



void creaPartitaDatabase() {
  DatabaseReference partiteRef = FirebaseDatabase.instance.ref().child("partite").child(widget.difficulty);
  DatabaseUtils databaseUtils = DatabaseUtils();
  // SE POSSO ASSOCIO L'UTENTE A UNA PARTITA
  databaseUtils.associaPartita(widget.difficulty,widget.topic, (associato,partita) {
    if (associato) {
      this.partita = partita;
    }
    // ALTRIMENTI CREO UNA PARTITA
    else {
      databaseUtils.creaPartita( partiteRef,widget.topic, (partita) {
        this.partita = partita;
      });
    }
  });
}

}


/*
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