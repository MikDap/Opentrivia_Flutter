import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/gioco/Vittoria.dart';
import 'package:opentrivia_flutter/gioco/argomento_singolo/ModArgomentoSingolo.dart';
import 'package:opentrivia_flutter/gioco/argomento_singolo/SceltaMultiplaFragment.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xDD0A013F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Colore del pulsante per Intrattenimento
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("geografia");
              },
              child: Text('Geografia'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Colore del pulsante per Sport
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("scienze");
              },
              child: Text('Scienze'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Colore del pulsante per Storia
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("arte");
              },
              child: Text('Arte'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Colore del pulsante per Geografia
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("storia");
              },
              child: Text('Storia'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Colore del pulsante per Arte
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("intrattenimento");
              },
              child: Text('Intrattenimento'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Colore del pulsante per Scienze
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Color(0xFFFDFCFC), // Bordo del pulsante per Scienze
                  ),
                ),
              ),
              onPressed: () {
                setTopic("sport");
              },
              child: Text('Sport'),
            ),
          ],
        ),
      ),
    );
  }
  void setTopic(String selectedTopic) {
    creaPartitaDatabase(selectedTopic);
    //per andare nella schermata partita tramite chiamata api(modifiche da finire)
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModArgomentoSingolo( difficulty: widget.difficulty, topic: selectedTopic
        ) //da cambiare quando aggiungeremo sceltamultipla
        )
    );
  }


  // Se trova una partita associa l'utente, altrimenti crea una partita
  void creaPartitaDatabase(String topic) {

    DatabaseReference partiteRef = database.ref().child("partite").child(widget.difficulty);

    final databaseUtils = DatabaseUtils();

      // Se posso, associo l'utente a una partita
      databaseUtils.associaPartita(widget.difficulty, topic, (associato, partita) {
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