import 'package:flutter/material.dart';

import 'StatFragment.dart';

class StatisticheActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiche'),
      ),
      body: StatFragment(),  // Sostituisci con il nome del tuo fragment Flutter
    );
  }
}
