import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/gioco/Vittoria.dart';
import 'package:opentrivia_flutter/gioco/argomento_singolo/SceltaMultiplaFragment.dart';

class ArgomentoSingoloFragment extends StatefulWidget {
  final String difficulty;

  ArgomentoSingoloFragment({required this.difficulty});

  @override
  _ArgomentoSingoloFragmentState createState() => _ArgomentoSingoloFragmentState();
}

class _ArgomentoSingoloFragmentState extends State<ArgomentoSingoloFragment> {
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
    //per andare nella schermata partita tramite chiamata api(modifiche da finire)
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Vittoria() //da cambiare quando aggiungeremo sceltamultipla
        )
    );
  }
}