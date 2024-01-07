import 'package:flutter/material.dart';

class SconfittaScreen extends StatefulWidget {
  @override
  _SconfittaScreenState createState() => _SconfittaScreenState();
}

class _SconfittaScreenState extends State<SconfittaScreen> {
  String persa = "Partita Persa";
  // Scrivere quante domande ha risposto rispetto al suo vecchio record
  String testomodificabile = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Sfondo rosso
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                persa,
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
      home: SconfittaScreen(),
    ),
  );
}

