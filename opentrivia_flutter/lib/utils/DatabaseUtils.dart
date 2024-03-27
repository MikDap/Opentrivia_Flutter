import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseUtils {
final FirebaseDatabase database = FirebaseDatabase.instance;
User? user = FirebaseAuth.instance.currentUser;
Future<void> associaPartita(String difficolta, String topic,
Function(bool, String) callback) async {
String? uid = user?.uid;
String? name = user?.displayName;
DatabaseReference partiteRef = database.ref().child("partite").child(
difficolta);
final partite = await partiteRef.once(DatabaseEventType.value);
final listaPartite = partite.snapshot;
bool associato = false;
String partita = "nessuna";
if (listaPartite.children.isNotEmpty) {
for (final partita1 in listaPartite.children) {
bool giocatoreDiverso = true;
String idAvversario = "-";
for (final giocatore in partita1
    .child("giocatori")
    .children) {
if (giocatore.key.toString() == uid) {
giocatoreDiverso = false;
} else {
idAvversario = giocatore.key.toString();
}
}
bool haFinitoTurno = false;
if (giocatoreDiverso &&
partita1.child("giocatori").child(idAvversario).hasChild(
"fineTurno")) {
haFinitoTurno = true;
}
if (partita1
    .child("inAttesa")
    .value == "si" && partita1.hasChild("topic") && giocatoreDiverso &&
haFinitoTurno) {
if (partita1
    .child("topic")
    .value == topic) {
//prende id della partita
partita = partita1.key.toString();

partiteRef.child(partita).child("giocatori").child(uid!).
set({"name": name}).then((_) {

return partiteRef.child(partita).update({"inAttesa": "no"});
});
associato = true;
break;
}
}
}
}
callback(associato, partita);
}
void creaPartita(DatabaseReference partiteRef, String topic,
Function(String) callback) {
String? uid = user?.uid;
String? name = user?.displayName;
String partita = partiteRef
    .push()
    .key
    .toString();
String inAttesa = "si";
partiteRef.child(partita).set({"inAttesa": inAttesa, "topic": topic,});
partiteRef.child(partita).child("giocatori").child(uid!).set({"name": name});
callback(partita);
}

Future<void> updateRisposte(DatabaseReference risposteRef,
String tipo) async {
final risposte = await risposteRef.once(DatabaseEventType.value);
final listaRisposte = risposte.snapshot;
// Se risposte corr o sbagl  esiste nel database aumentiamo i punti di 1
if (listaRisposte.child(tipo).exists) {
int punti = int.parse(listaRisposte.child(tipo).value.toString());
punti++;
risposteRef.child(tipo).set(punti);
}
// Altrimenti settiamo a 1
else {
risposteRef.child(tipo).set(1);
}
// Se risposte/risposte totali esiste nel database aumentiamo le risposte totali di 1
if (listaRisposte
    .child("risposteTotali")
    .exists) {
int punti = int.parse(listaRisposte
    .child("risposteTotali")
    .value
    .toString());
punti++;
risposteRef.child("risposteTotali").set(punti);
}
// Altrimenti le settiamo a 1
else {
risposteRef.child("risposteTotali").set(1);
}
}
Future<void> getAvversario(String difficolta, String partita,
Function(bool, String, String) callback) async {
DatabaseReference giocatoriRef = FirebaseDatabase.instance.ref()
    .child("partite").child(difficolta).child(partita).child("giocatori");
String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
bool giocatore2esiste = false;
String avversario = "-";
String nomeAvv = "-";
bool avversarioTrovato = false;
try {
final giocatori = await giocatoriRef.once();
DataSnapshot listaGiocatori = giocatori.snapshot;
if (listaGiocatori.exists) {
listaGiocatori.children.forEach((giocatore) {
if (!avversarioTrovato && giocatore.key != uid) {
giocatore2esiste = true;
avversario = giocatore.key!;
nomeAvv = giocatore
    .child("name")
    .value
    .toString();
avversarioTrovato = true;
}
});
callback(giocatore2esiste, avversario, nomeAvv);
} else {
print("La lista dei giocatori non contiene elementi");
}
} catch (error) {
print("Errore: $error");
}
}

Future<void> getRispCorrette(String difficolta, String partita,
Function(int, int) callback) async {
DatabaseReference giocatoriRef = FirebaseDatabase.instance.ref().child(
"partite").child(difficolta).child(partita).child("giocatori");
String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
int risposte1 = 0;
int risposte2 = 0;
try {
final giocatoreR = await giocatoriRef.once();
DataSnapshot giocatore = giocatoreR.snapshot;
//da continuare
if (giocatore.value != null) {
for (DataSnapshot rispostedb in giocatore.children) {
if (rispostedb.hasChild("risposteTotali")) {
String giocatore1 = rispostedb.key.toString();
print('uid2, $giocatore');
// PER ME
var risposteCorrette = rispostedb
    .child("risposteCorrette")
    .value;
if (risposteCorrette != null && risposteCorrette is int) {
print('uid, $giocatore1');
if (giocatore1 == uid) {
print("entra");
risposte1 += risposteCorrette;
}
else {
risposte2 += risposteCorrette;
}
// PER AVVERSARIO
}
}
}
callback(risposte1, risposte2);
} else {
print("Il giocatore non ha dati nel database");
}
} catch (error) {
print("Errore: $error");
}
}
//Gestione partite nel database
Future<void> spostaInPartiteTerminate(String partita, String difficolta,
String utente, int risposte1, int risposte2, bool ritirato) async {
var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
var refToCopy = database.ref().child("partite").child(difficolta).child(
partita);
try {
final copia = await refToCopy.once();
DataSnapshot leggicopia = copia.snapshot;
if (leggicopia.value != null) {
for(var giocatore in leggicopia.child("giocatori").children)
{ var giocatore2= giocatore.key;
refToCopy.child("giocatori").child(giocatore2.toString()).child("fineTurno").remove();
}
refToCopy.child("inAttesa").remove();
final copiaAggiornata = await refToCopy.once();
DataSnapshot copiaModificata = copiaAggiornata.snapshot;

var dataToCopy = copiaModificata.value;
var refToNewNode = database.ref().child("users").child(utente).child(
"partite terminate").child(difficolta).child(partita);
refToNewNode.set(dataToCopy).then((_) {
refToCopy.remove();
var refToNewNode = database.ref().child("users").child(utente).child(
"partite terminate").child(difficolta).child(partita);


if (utente == uid ) { if(!ritirato){
refToNewNode.child("esito").child("io").set(risposte1);
refToNewNode.child("esito").child("avversario").set(risposte2);
}
}
else {if(!ritirato) {
refToNewNode.child("esito").child("io").set(risposte2);
refToNewNode.child("esito").child("avversario").set(risposte1);
}}
});
}
}
catch (error) {
print("Errore: $error");
}
}
}