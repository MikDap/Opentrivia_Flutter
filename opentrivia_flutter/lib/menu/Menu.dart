import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Button startButton;
  late LinearLayout partitaContainer;
  late FirebaseDatabase database;
  late Button giocaincorso;
  late Button inattesa;
  late ModClassicaActivity modClassicaActivity;
  late ConstraintLayout background_game_item;
  late Button visualizzaCronologia;
  late TextView notification;
  late ImageView sfida;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Button(
                onPressed: () {
                  Navigator.pushNamed(context, '/modalita');
                },
                child: Text('Start'),
              ),
              Button(
                onPressed: () {
                  Navigator.pushNamed(context, '/cronologiaPartite');
                },
                child: Text('Visualizza Cronologia'),
              ),
              ImageView(
                image: AssetImage('your_image_asset_path'), // Replace with your actual image path
              ),
              TextView(
                text: 'Notification',
              ),
              ImageView(
                image: AssetImage('your_image_asset_path'), // Replace with your actual image path
                onPressed: () {
                  Navigator.pushNamed(context, '/sfidaFragment');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// Restante parte del codice in Dart...

// Nota: Alcuni widget specifici come AlertDialog, OnBackPressedCallback, e altre funzionalità native di Android
// potrebbero non avere corrispondenti diretti in Flutter. È possibile utilizzare pacchetti di terze parti o creare
// widget personalizzati per replicare alcune di queste funzionalità, a seconda delle tue esigenze specifiche.
}
