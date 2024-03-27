import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PartitaTerminata.dart';
class CronologiaPartite extends StatefulWidget {
@override
_CronologiaPartiteState createState() => _CronologiaPartiteState();
}
class _CronologiaPartiteState extends State<CronologiaPartite> {
late final Map<int, PartitaTerminata> partiteList;
late String uid;
late DatabaseReference partiteTerminateRef;
late PartitaTerminata partitaTerminata;
@override
void initState() {
super.initState();
partiteList = {};
uid = FirebaseAuth.instance.currentUser!.uid;
partiteTerminateRef = FirebaseDatabase.instance
    .ref()
    .child('users')
    .child(uid)
    .child('partite terminate');
_loadPartiteTerminate();
}
void _loadPartiteTerminate() {
partiteTerminateRef.onValue.listen((event) {
DataSnapshot partite = event.snapshot;
partiteList.clear();
var position = 0;
for (DataSnapshot difficolta in partite.children) {
for (DataSnapshot partita in difficolta.children) {
bool ritirato = false;
bool avvRitirato = false;
bool avvEsiste = false;
for (DataSnapshot giocatore in partita
    .child('giocatori')
    .children) {
var giocatore1 = giocatore.key.toString();
if (giocatore1 == uid) {
if (giocatore.hasChild('ritirato')) {
ritirato = true;
}
} else {
if (giocatore.hasChild('ritirato')) {
avvRitirato = true;
}
avvEsiste = true;
var nomeAvv = giocatore
    .child('name')
    .value
    .toString();
var scoreMio = partita
    .child('esito')
    .child('io')
    .value
    .toString();
var scoreAvv =
partita
    .child('esito')
    .child('avversario')
    .value
    .toString();
var partitaTer = PartitaTerminata(
nomeAvv, scoreMio, scoreAvv, ritirato, avvRitirato);
partiteList[position] = partitaTer;
}
}
if (!avvEsiste) {
var nomeAvv = 'TI SEI RITIRATO';
var scoreMio = partita
    .child('esito')
    .child('io')
    .value
    .toString();
var scoreAvv = partita
    .child('esito')
    .child('avversario')
    .value
    .toString();
var partitaTer = PartitaTerminata(
nomeAvv, scoreMio, scoreAvv, ritirato, false);
partiteList[position] = partitaTer;
}
else {
if (ritirato) {
var nomeAvv = 'TI SEI RITIRATO';
var scoreMio = partita
    .child('esito')
    .child('io')
    .value
    .toString();
var scoreAvv = partita
    .child('esito')
    .child('avversario')
    .value
    .toString();
var partitaTer = PartitaTerminata(
nomeAvv, scoreMio, scoreAvv, ritirato, false);
partiteList[position] = partitaTer;
}
if (avvRitirato) {
var nomeAvv = 'AVVERSARIO RITIRATO';
var scoreMio = partita
    .child('esito')
    .child('io')
    .value
    .toString();
var scoreAvv = partita
    .child('esito')
    .child('avversario')
    .value
    .toString();
var partitaTer = PartitaTerminata(
nomeAvv, scoreMio, scoreAvv, false, avvRitirato);
partiteList[position] = partitaTer;
}
position++;
}
}
}
setState(() {});
}, onError: (Object? error) {
// Handle error
});
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Cronologia Partite'),
),
body: Container(
decoration: BoxDecoration(
gradient: LinearGradient(
colors: [Color(0xFF2F6AEC), Color(0xFF70B8FF)],
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
),
),
child: ListView.builder(
itemCount: partiteList.length,
itemBuilder: (context, position) {
var partita = partiteList[position];
if (partita != null) {
return Container(
margin: EdgeInsets.all(2),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(8),
border: Border.all(
color: coloraSfondoPartita(partita),
width: 2,
),
),
child: ListTile(
title: Text(
partita.nomeAvv.toString() ,
textAlign: TextAlign.center,
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
if (!partita.ritirato && !partita.avvRitirato)
Text(
'${partita.punteggioMio}-${partita.punteggioAvv}',
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 18,
),
),
],
),
tileColor: null,
),
);
}
return Container();
},
),
),
);
}
Color coloraSfondoPartita(PartitaTerminata partita) {
var punteggioMioStr = partita.punteggioMio ?? '';
var punteggioAvvStr = partita.punteggioAvv ?? '';
var ritirato = partita.ritirato;
var avvRitirato = partita.avvRitirato;
Color borderColor;
if (ritirato) {
borderColor = Colors.red;
} else if (avvRitirato) {
borderColor = Colors.green;
} else {
var punteggioMio = punteggioMioStr.isNotEmpty ? int.tryParse(punteggioMioStr) ?? 0 : 0;
var punteggioAvv = punteggioAvvStr.isNotEmpty ? int.tryParse(punteggioAvvStr) ?? 0 : 0;
if (punteggioMio > punteggioAvv) {
borderColor = Colors.green;
} else if (punteggioMio < punteggioAvv) {
borderColor = Colors.red;
} else {
borderColor = Colors.grey;
}
}
return borderColor; // Restituisci solo il colore del bordo
}
}