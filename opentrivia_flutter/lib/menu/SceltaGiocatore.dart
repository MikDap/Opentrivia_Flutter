import 'package:flutter/material.dart';

class Difficolta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selezione Difficoltà'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToSceltaGiocatore(context, 'easy');
              },
              child: Text('Facile'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToSceltaGiocatore(context, 'medium');
              },
              child: Text('Medio'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToSceltaGiocatore(context, 'hard');
              },
              child: Text('Difficile'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSceltaGiocatore(BuildContext context, String difficulty) {
    final modalita = ModalRoute.of(context)!.settings.arguments as String?;

    Navigator.pushNamed(
      context,
      '/sceltaGiocatore',
      arguments: {
        'modalita': modalita,
        'difficolta': difficulty,
      },
    );
  }
}
