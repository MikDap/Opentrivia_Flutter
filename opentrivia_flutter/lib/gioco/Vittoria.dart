import 'package:flutter/material.dart';

class VittoriaScreen extends StatefulWidget {
  @override
  _VittoriaScreenState createState() => _VittoriaScreenState();
}

class _VittoriaScreenState extends State<VittoriaScreen> {
  String vittoria = "NUOVO RECORD";
  // Scrivere quante domande ha risposto rispetto al suo vecchio record
  String testomodificabile = "hai risposto a tot domande ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Sfondo rosso
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                vittoria,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                testomodificabile,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  // Logica per tornare al menu
                  // Torna alla schermata precedente
                },
                child: Text(
                  'Torna al Menu',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(
    MaterialApp(
      home: VittoriaScreen(),
    ),
  );
}

