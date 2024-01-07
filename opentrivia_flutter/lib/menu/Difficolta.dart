import 'package:flutter/material.dart';

import '../gioco/argomento_singolo/ArgomentoSingoloFragment.dart';

class Difficolta extends StatelessWidget {
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
        MaterialPageRoute(builder: (context) => ArgomentoSingoloFragment(
            difficulty: difficulty
        )
        )
    );
  }

}