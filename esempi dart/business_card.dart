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
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                          Icon(Icons.account_circle, size: 50),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Flutter McFlutter',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        const Text('Experienced App Developer'),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      '123 Main Street',
                                    ),
                                    Text(
                                      '(415) 555-0198',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(Icons.accessibility),
                                    Icon(Icons.timer),
                                    Icon(Icons.phone_android),
                                    Icon(Icons.phone_iphone),
                                  ],
                                ),
                              ],
                            )))))));
  }
}
