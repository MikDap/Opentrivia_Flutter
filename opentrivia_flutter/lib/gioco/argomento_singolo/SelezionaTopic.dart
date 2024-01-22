import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/gioco/Vittoria.dart';
import 'package:opentrivia_flutter/gioco/argomento_singolo/ModArgomentoSingolo.dart';
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
      child: Text(
        label,
        style: TextStyle(
          color: getTextColorForTopic(topic),
        ),
      ),
    );
  }

  Color getColorForTopic(String topic) {
    switch (topic) {
      case "geografia":
        return Colors.blue;
      case "scienze":
        return Colors.green;
      case "arte":
        return Colors.red;
      case "storia":
        return Colors.orange;
      case "intrattenimento":
        return Colors.purple;
      case "sport":
        return Colors.amber;
      default:
        return Colors.grey; // Aggiungi un colore predefinito o gestisci il caso di default a seconda delle tue esigenze
    }
  }

  Color getTextColorForTopic(String topic) {
    // Imposta il colore del testo a bianco solo per "Geografia" e "Arte"
    return topic == "geografia" || topic == "arte" || topic == "storia" || topic == "intrattenimento" || topic == "sport" || topic == "scienze" ? Colors.white : Colors.black;
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
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),

            ),
            SizedBox(height: 20.0),
            buildElevatedButton('Geografia', 'geografia'),
            SizedBox(height: 10.0),
            buildElevatedButton('Scienze', 'scienze'),
            SizedBox(height: 10.0),
            buildElevatedButton('Arte', 'arte'),
            SizedBox(height: 10.0),
            buildElevatedButton('Storia', 'storia'),
            SizedBox(height: 10.0),
            buildElevatedButton('Intrattenimento', 'intrattenimento'),
            SizedBox(height: 10.0),
            buildElevatedButton('Sport', 'sport'),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }


  void setTopic(String selectedTopic) {
    creaPartitaDatabase(selectedTopic);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SceltaMultipla(
          difficulty: widget.difficulty,
          topic: selectedTopic,
        ),
      ),
    );
  }

  void creaPartitaDatabase(String topic) {
    DatabaseReference partiteRef =
    database.ref().child("partite").child(widget.difficulty);

    final databaseUtils = DatabaseUtils();

    databaseUtils.associaPartita(widget.difficulty, topic, (associato, partita) {
      if (associato) {
        setState(() {
          this.partita = partita;
        });
      } else {
        databaseUtils.creaPartita(partiteRef, topic, (partita) {

          setState(() {
            this.partita = partita;
          });
        });
      }
    });
  }
}