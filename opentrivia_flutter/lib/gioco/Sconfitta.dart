import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "BusinessCart",
        home: Scaffold(
            body: Center(
                child: Card(
                    color: Colors.red,
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
                                      Icon(Icons.sentiment_dissatisfied, size: 50),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Hai perso con Nome Avversario',
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