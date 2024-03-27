import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';

class AttendiTurno extends StatelessWidget {
  late final Text scoreMio;

  AttendiTurno({
    required this.scoreMio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Lottie.asset(
                            "assets/animations/time.json",
                            repeat: true,
                            width: 52,
                            height: 52,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Attendi il tuo avversario',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.03,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Risposte corrette:',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                    ),
                                  ),
                                  SizedBox(width: 8), // Aggiunto spazio tra i due Text
                                  Text(
                                    scoreMio.data ?? '',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      SizedBox(height: 14),
                      InkWell(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Menu()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_rounded),
                            Text(
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
          ],
        ),
      ),
    );
  }
}
