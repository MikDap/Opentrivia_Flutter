import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';

class Pareggio extends StatelessWidget {
  late final String nomeAvv;
  late final Text scoreMio;
  late final Text scoreAvv;

  Pareggio({
    required this.nomeAvv,
    required this.scoreAvv,
    required this.scoreMio,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BusinessCart",
      home: Scaffold(
        body: Center(
          child: Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 480,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.sentiment_neutral, size: 50),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Hai pareggiato con '+nomeAvv,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          scoreMio.data ?? '',
                          style: TextStyle(fontSize: 30),
                        ),
                     const  Text(
                          '  -  ',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          scoreAvv.data ?? '',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () {
                        // Naviga alla schermata Menu.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_rounded),
                          const Text(
                            'Torna al menu',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
