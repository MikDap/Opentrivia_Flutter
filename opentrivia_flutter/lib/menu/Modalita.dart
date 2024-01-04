import 'package:flutter/material.dart';

class Modalita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToDifficolta(context, "classica");
              },
              child: Text('Classica'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToDifficolta(context, "a tempo");
              },
              child: Text('A Tempo'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToDifficolta(context, "argomento singolo");
              },
              child: Text('Argomento Singolo'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDifficolta(BuildContext context, String modalita) {
    Navigator.pushNamed(context, '/difficolta', arguments: {"modalita": modalita});
  }
}
