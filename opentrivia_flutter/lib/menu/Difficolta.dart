import 'package:flutter/material.dart';

import '../api/ChiamataApi.dart';
import '../gioco/argomento_singolo/SelezionaTopic.dart';

class Difficolta extends StatelessWidget
//implements TriviaQuestionCallback
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xDD0A013F),
      appBar: AppBar(
        title: Text('Seleziona Difficoltà'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(
              onPressed: () {
                _impostaDifficoltaCpu(context, 'easy');
              },
              child: Text('Facile'),

            ),
            ElevatedButton(
              onPressed: () {
                _impostaDifficoltaCpu(context, 'medium');
              },
              child: Text('Medio'),
            ),
            ElevatedButton(
              onPressed: () {
                _impostaDifficoltaCpu(context, 'hard');
              },
              child: Text('Difficile'),
            ),
          ],
        ),
      ),
    );
  }

  void _impostaDifficoltaCpu(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelezionaTopic( difficulty: difficulty
    )
      )
    );

//eseguiChiamataApi();
}
/*
  void eseguiChiamataApi() {
    // Creare un'istanza di ChiamataApi
    ChiamataApi chiamataApi = ChiamataApi("multiple", "23", "easy");

    // Chiamare il metodo fetchTriviaQuestion passando l'istanza corrente
    chiamataApi.fetchTriviaQuestion(this);
  }

  @override
  void onTriviaQuestionFetched(
      String tipo,
      String domanda,
      String rispostaCorretta,
      String rispostaSbagliata1,
      String rispostaSbagliata2,
      String rispostaSbagliata3,
      ) {
    // Gestire la risposta ottenuta dalla chiamata API
    print("Domanda: $domanda");
    print("Risposta Corretta: $rispostaCorretta");
    print("Risposta Sbagliata 1: $rispostaSbagliata1");
    print("Risposta Sbagliata 2: $rispostaSbagliata2");
    print("Risposta Sbagliata 3: $rispostaSbagliata3");
  }*/
}