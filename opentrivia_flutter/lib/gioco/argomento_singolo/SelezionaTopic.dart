import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/gioco/argomento_singolo/SceltaMultipla.dart';
import 'package:opentrivia_flutter/utils/DatabaseUtils.dart';
class SelezionaTopic extends StatefulWidget {
final String difficulty;
SelezionaTopic({required this.difficulty});
@override
_SelezionaTopicState createState() => _SelezionaTopicState();
}
class _SelezionaTopicState extends State<SelezionaTopic> {
static final FirebaseDatabase database = FirebaseDatabase.instance;
late String partita;
ElevatedButton buildElevatedButton(String label, String topic) {
return ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: getColorForTopic(topic),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8.0),
side: BorderSide(
width: 2.0,
color: Color(0xFFFDFCFC),
),
),
),
onPressed: () {
setTopic(topic);
},
child: SizedBox(
width: MediaQuery.of(context).size.width * 0.280, // Imposta la larghezza fissa desiderata
height: MediaQuery.of(context).size.height * 0.085, // Imposta l'altezza fissa desiderata
child: Center(
child: Text(
label,
style: TextStyle(
color: getTextColorForTopic(topic),
fontSize: MediaQuery.of(context).size.width * 0.030,
),
),
),
),
);
}
Color getColorForTopic(String topic) {
switch (topic) {
case "Geografia":
return Colors.blue;
case "Scienze":
return Colors.green;
case "Arte":
return Colors.red;
case "Storia":
return Colors.orange;
case "Intrattenimento":
return Colors.purple;
case "Sport":
return Colors.amber;
default:
return Colors.grey; // Aggiungi un colore predefinito o gestisci il caso di default a seconda delle tue esigenze
}
}
Color getTextColorForTopic(String topic) {
// Imposta il colore del testo a bianco solo per "Geografia" e "Arte"
return topic == "Geografia" || topic == "Arte" || topic == "Storia" || topic == "Intrattenimento" || topic == "Sport" || topic == "Scienze" ? Colors.white : Colors.black;
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xDD0A013F),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
'Seleziona la materia',
style: TextStyle(
color: Colors.white,
fontSize: MediaQuery.of(context).size.width * 0.050,
fontFamily: 'Maven_Pro',
),
),
SizedBox(height: 20.0),
buildElevatedButton('Geografia', 'Geografia'),
SizedBox(height: 12.0),
buildElevatedButton('Scienze', 'Scienze'),
SizedBox(height: 12.0),
buildElevatedButton('Arte', 'Arte'),
SizedBox(height: 12.0),
buildElevatedButton('Storia', 'Storia'),
SizedBox(height: 12.0),
buildElevatedButton('Intrattenimento', 'Intrattenimento'),
SizedBox(height: 12.0),
buildElevatedButton('Sport', 'Sport'),
SizedBox(height: 12.0),
  ///
],
),
),
);
}

Future<void> setTopic(String selectedTopic) async {
await creaPartitaDatabase(selectedTopic);
//per andare nella schermata partita tramite chiamata api(modifiche da finire)
Navigator.push(
context,
//scelta multipla da modificare
MaterialPageRoute(builder: (context) => SceltaMultipla(difficulty: widget.difficulty, topic: selectedTopic,contatoreRisposte: 0,risposteCorrette: 0, risposteSbagliate:0, partita: partita, nomeMateria: selectedTopic,apiEseguita: false,
) //da cambiare quando aggiungeremo sceltamultipla
)
);
}

// Se trova una partita associa l'utente, altrimenti crea una partita
Future<void> creaPartitaDatabase(String topic) async {
DatabaseReference partiteRef = database.ref().child("partite").child(widget.difficulty);
final databaseUtils = DatabaseUtils();
// Se posso, associo l'utente a una partita
await databaseUtils.associaPartita(widget.difficulty, topic, (associato, partita) {
if (associato) {
setState(() {
this.partita = partita;
});
} else {
// Altrimenti, creo una partita
databaseUtils.creaPartita(partiteRef, topic, (partita) {
setState(() {
this.partita = partita;
});
});
}
});
}
}