import 'package:flutter/material.dart';

class ListaAmiciActivity extends StatefulWidget {
  @override
  _ListaAmiciActivityState createState() => _ListaAmiciActivityState();
}

class _ListaAmiciActivityState extends State<ListaAmiciActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Amici'),
      ),
      body: ListaAmiciPage(),
    );
  }
}

class ListaAmiciPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Inserisci qui il contenuto della tua schermata Lista Amici
      child: Text('Contenuto Lista Amici'),
    );
  }
}
