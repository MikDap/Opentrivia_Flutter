import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/main.dart'; // Assicurati di importare il modulo corretto

class Sconfitta extends StatelessWidget {
  late TextView NomeAvversario;
  late TextView scoreTextView1;
  late TextView scoreTextView3;
  late TextView modalita;
  late String nomeAvv;
  late String scoreMio;
  late String scoreAvv;
  late String mod;
  late Button menu;
  late Intent intent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSconfittaView(),
    );
  }

  Widget _buildSconfittaView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nome Avversario: $nomeAvv'),
          Text('Score Mio: $scoreMio'),
          Text('Score Avversario: $scoreAvv'),
          Text('Modalità: $mod'),
          ElevatedButton(
            onPressed: () {
              _startMainActivity(context);
            },
            child: Text('Esci'),
          ),
        ],
      ),
    );
  }

  void _startMainActivity(BuildContext context) {
    intent = Intent(context, MainActivity::class);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainActivity()));
  }
}
