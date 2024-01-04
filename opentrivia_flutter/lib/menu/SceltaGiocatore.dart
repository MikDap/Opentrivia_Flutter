import 'package:flutter/material.dart';

class SceltaGiocatore extends StatefulWidget {
  @override
  _SceltaGiocatoreState createState() => _SceltaGiocatoreState();
}

class _SceltaGiocatoreState extends State<SceltaGiocatore> {
  late String modalita;
  late String difficolta;
  String selezione = "nessuno";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    modalita = arguments['modalita']!;
    difficolta = arguments['difficolta']!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _handleButtonPress("casuale");
              },
              child: Text('Casuale'),
              style: _getButtonStyle("casuale"),
            ),
            ElevatedButton(
              onPressed: () {
                _handleButtonPress("amico");
              },
              child: Text('Amico'),
              style: _getButtonStyle("amico"),
            ),
            ElevatedButton(
              onPressed: () {
                _handleContinuaButtonPress();
              },
              child: Text('Continua'),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(String buttonType) {
    return selezione == buttonType
        ? ElevatedButton.styleFrom(primary: Colors.orange)
        : ElevatedButton.styleFrom(primary: Colors.grey);
  }

  void _handleButtonPress(String buttonType) {
    setState(() {
      selezione = buttonType;
    });
  }

  void _handleContinuaButtonPress() {
    if (selezione == "casuale" || selezione == "amico") {
      Navigator.pushNamed(
        context,
        '/iniziaPartita',
        arguments: {
          'modalita': modalita,
          'difficolta': difficolta,
          'selezione': selezione,
        },
      );
    } else {
      Toast.show("Seleziona un avversario!", context, duration: Toast.LENGTH_SHORT);
    }
  }
}
