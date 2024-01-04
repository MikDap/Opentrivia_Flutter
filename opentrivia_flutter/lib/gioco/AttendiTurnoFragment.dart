import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/main.dart'; // Assicurati di importare il modulo corretto

class AttendiTurnoFragment extends StatelessWidget {
  late Button menu;
  late Intent intent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAttendiTurnoView(),
    );
  }

  Widget _buildAttendiTurnoView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
