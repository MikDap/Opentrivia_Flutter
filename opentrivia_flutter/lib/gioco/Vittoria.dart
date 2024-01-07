
import 'package:flutter/material.dart';
/*
class VittoriaScreen extends StatefulWidget {
  @override
  _VittoriaScreenState createState() => _VittoriaScreenState();
}
class _VittoriaScreenState extends State<VittoriaScreen> {
  String vittoria = "NUOVO RECORD";
  // Scrivere quante domande ha risposto rispetto al suo vecchio record
  String testomodificabile = "hai risposto a tot domande ";
=======
void main() => runApp(MyApp());*/

class Vittoria extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: "BusinessCart",
home: Scaffold(
body: Center(
child: Card(
color: Colors.green,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: SizedBox(
width: 420,
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Row(
children: [
const Padding(
padding: EdgeInsets.all(8.0),
child:
Icon(Icons.sentiment_satisfied, size: 50),
),
Column(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
Text(
'Hai vinto con Nome Avversario',
style: Theme.of(context)
    .textTheme
    .headlineSmall,
),
],
),
],
),
const SizedBox(height: 8),
const Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
Text(
'0',
style: TextStyle(fontSize: 30),
),
Text(
'-',
style: TextStyle(fontSize: 30),
),
Text(
'0',
style: TextStyle(fontSize: 30),
),
],
),
Divider(
color: Colors.white,
thickness: 1,
),
const SizedBox(height: 14),
const Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [

Icon(Icons.home_rounded),
Text(
'Torna al menu',
style: TextStyle(fontSize: 18),)
],
),
],
)))))));
}
}
 