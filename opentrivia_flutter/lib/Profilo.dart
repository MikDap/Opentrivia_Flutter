import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
class Profilo extends StatefulWidget {
@override
_ProfiloState createState() => _ProfiloState();
}
class _ProfiloState extends State<Profilo> {
final databaseReference = FirebaseDatabase.instance.ref();
late String uid;
String nomeUtente = '';
@override
void initState(){
super.initState();
uid = FirebaseAuth.instance.currentUser!.uid;
retrieveUsername(); // Richiama la funzione per recuperare il nome utente quando il widget viene creato
}
// Funzione per recuperare il nome utente dal database Firebase
Future<void> retrieveUsername() async {
var usersRef = databaseReference.child('users').child(uid);
final user = await usersRef.once();
DataSnapshot leggiuser = user.snapshot;
setState(() {
int randomNumber = generateRandomNumber();
if(leggiuser.child('name').value != '') {
nomeUtente = leggiuser
    .child('name')
    .value.toString();
}
else { nomeUtente = 'user$randomNumber';
usersRef.child('name').set(nomeUtente);
}
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Profilo'),
),
    body: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Color(0xFF2F6AEC), Color(0xFF70B8FF)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  ),
    ),
child: nomeUtente.isNotEmpty // Controlla se il nome utente è stato recuperato con successo
? Center(
child: Text(
'Benvenuto, $nomeUtente!',
style: TextStyle(fontSize: 20),
),
)
    : Center(
child: CircularProgressIndicator(), // Visualizza un indicatore di caricamento se il nome utente è in fase di recupero
),
),
);
}
int generateRandomNumber() {
Random random = Random();
return random.nextInt(10000);
}
}
