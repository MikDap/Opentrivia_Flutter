import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Domanda e Risposte'),
        ),
        body: QuestionScreen(),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Domanda in cima
          Text(
            'Qual è la tua domanda?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16), // Spazio tra domanda e risposte

          // Risposte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnswerOption('Risposta 1'),
                AnswerOption('Risposta 2'),
                AnswerOption('Risposta 33'),
                AnswerOption('Risposta 4'),
                Spacer(), // Distribuisce lo spazio rimanente
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String answer;

  AnswerOption(this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(answer),
        onTap: () {
          // Aggiungi qui la logica per gestire la risposta selezionata
        },
      ),
    );
  }
}
