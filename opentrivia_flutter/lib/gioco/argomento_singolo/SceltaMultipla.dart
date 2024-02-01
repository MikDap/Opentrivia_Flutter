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

SceltaMultipla({
required this.partita,
required this.difficulty,
required this.topic,
required this.contatoreRisposte,
required this.nomeMateria,
required this.risposteCorrette,
required this.risposteSbagliate,
});
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
return buildUI();
}
print('CircularProgressIndicator()');
return CircularProgressIndicator();
},
);
}
Future<void> initData() async {
super.initState();
giocatoriRef = database.ref().child("partite").child(widget.difficulty).child(widget.partita);
//ritiratoRef = giocatoriRef.child(uid);
risposteRef = giocatoriRef.child(uid).child(widget.topic);
await creaPartitaDatabase();
//await controllaRitiro();
}
Widget buildUI() {
print('domanda,$domanda');
if (
(domanda.data != null && domanda.data!.isNotEmpty) ||
(risposta1.data != null && risposta1.data!.isNotEmpty) ||
(risposta2.data != null && risposta2.data!.isNotEmpty) ||
(risposta3.data != null && risposta3.data!.isNotEmpty) ||
(risposta4.data != null && risposta4.data!.isNotEmpty) ||
rispostaCorretta.isNotEmpty
) {
print('domanda.data != null && domanda.data!.isNotEmpty');
// Tutte le variabili sono popolate, costruisci il widget QuizCard
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
style: const TextStyle(fontSize: 18.0,
fontWeight: FontWeight.bold,
color: Colors.green),
),
),
Padding(
padding: const EdgeInsets.only(right: 18.0),
child: Text(
'Sbagliate: ${widget.risposteSbagliate}',
style: const TextStyle(fontSize: 18.0,
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
),
),
],
),
),
);
}
else {
print('child: CircularProgressIndicator()');
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
print('entraaa');
var categoria = GiocoUtils().getCategoria(widget.topic);
print('categoria,$categoria');
// Creare un'istanza di ChiamataApi
ChiamataApi chiamataApi = ChiamataApi("multiple", categoria, widget.difficulty);
// Chiamare il metodo fetchTriviaQuestion passando l'istanza corrente
chiamataApi.fetchTriviaQuestion(this);
}


Future <void> creaPartitaDatabase() async{
DatabaseReference partiteRef = FirebaseDatabase.instance.ref().child("partite").child(widget.difficulty);
DatabaseUtils databaseUtils = DatabaseUtils();
// SE POSSO ASSOCIO L'UTENTE A UNA PARTITA
String top=widget.topic;
String top1=widget.difficulty;
String top2=widget.partita;
print('widget.topic,$top');
print('widget.difficulty,'+ '$top1');
print('widget.partita,$top2');
databaseUtils.associaPartita(widget.difficulty,widget.topic, (associato,partita) {
if (associato) {
this.widget.partita = partita;
}
// ALTRIMENTI CREO UNA PARTITA
else {
databaseUtils.creaPartita( partiteRef,widget.topic, (partita) {
this.widget.partita = partita;
});
}
});
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
required this.risposteCorrette,
required this.risposteSbagliate,
required this.nomeMateria,
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
if (!rispostaData) {
setState(() {
selectedAnswer = answerText.data ?? '';
print('selectedAnswer: $selectedAnswer');
if (GiocoUtils().questaELaRispostaCorretta(selectedAnswer, widget.rispostaCorretta)) {
// Logica per risposta corretta
DatabaseUtils().updateRisposte(widget.risposteRef, "risposteCorrette");
widget.risposteCorrette++;
} else {
// Logica per risposta sbagliata
DatabaseUtils().updateRisposte(widget.risposteRef, "risposteSbagliate");
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
),
),
);
} else { String ciao= widget.uid.toString();
print(':$ciao');
finePartita(widget.giocatoriRef,widget.uid);
}
}
resetSelectedAnswer(); },
style: ElevatedButton.styleFrom(
backgroundColor: selectedAnswer.isNotEmpty && selectedAnswer == answerText.data
? (GiocoUtils().questaELaRispostaCorretta(selectedAnswer, widget.rispostaCorretta)
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
Text r1 = Text(risposte1.toString());
giocatoriRef.child(uid).child("fineTurno").set("si");
GiocoUtils().schermataAttendi(context,r1);
//requireActivity().supportFragmentManager, R.id.fragmentContainerViewGioco2);
}
else {print('risposte1,$risposte1');
print('risposte1,$risposte2');/*
          giocatoriRef.child(uid).child("fineTurno").setValue("si");
          GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, uid, risposte1, risposte2);
          GiocoUtils.spostaInPartiteTerminate(partita, modalita, difficolta, avversario, risposte1, risposte2);
*/      Text r1 = Text(risposte1.toString());
Text r2 = Text(risposte2.toString());
switch (risposte1.compareTo(risposte2)) {
case 0:
GiocoUtils().schermataPareggio(context, nomeAvv, r1, r2);
break;
case 1:
GiocoUtils().schermataVittoria(context, nomeAvv, r1, r2);
break;
case -1:
GiocoUtils().schermataSconfitta(context, nomeAvv, r1, r2);
break;
default:
// Handle any other case if needed
break;
}
}
});
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