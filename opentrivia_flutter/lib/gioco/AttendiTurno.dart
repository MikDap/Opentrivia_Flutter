import 'package:flutter/material.dart';

class AttendiTurno extends StatelessWidget {

  late final Text scoreMio;


  AttendiTurno({
    required this.scoreMio,
  });
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: "BusinessCart",
        home: Scaffold(
            body: Center(
                child: Card(
                    color: Colors.white70,
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
                                      Icon(Icons.hourglass_empty, size: 50),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Attendi il turno del tuo avversario',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        Text(
                                          'Tue risposte corrette:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        Text(
                                            scoreMio.data?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
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


