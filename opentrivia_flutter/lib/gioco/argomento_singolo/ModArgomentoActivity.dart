import 'package:flutter/material.dart';

class ArgomentoSingoloFragment extends StatefulWidget {
  @override
  _ArgomentoSingoloFragmentState createState() =>
      _ArgomentoSingoloFragmentState();
}

class _ArgomentoSingoloFragmentState extends State<ArgomentoSingoloFragment> {
  late String argomento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Sostituisci questo con il tuo layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                argomento = "culturaPop";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Cultura Pop"),
            ),
            ElevatedButton(
              onPressed: () {
                argomento = "sport";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Sport"),
            ),
            ElevatedButton(
              onPressed: () {
                argomento = "storia";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Storia"),
            ),
            ElevatedButton(
              onPressed: () {
                argomento = "geografia";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Geografia"),
            ),
            ElevatedButton(
              onPressed: () {
                argomento = "scienze";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Scienze"),
            ),
            ElevatedButton(
              onPressed: () {
                argomento = "arte";
                passaVariabileAlWidget(argomento);
              },
              child: Text("Arte"),
            ),
          ],
        ),
      ),
    );
  }

  // Definisci il tipo della funzione di callback
  typedef void FunzioneDiCallback(String variabile);

  // Funzione di callback per passare l'argomento selezionato al widget di hosting
  void passaVariabileAlWidget(String variabile) {
    // Ottieni il discendente più vicino del widget corrente che corrisponde al tipo generico
    FunzioneDiCallback? callback =
    context.findAncestorWidgetOfExactType<FunzioneDiCallback>();
    // Chiama la callback se trovata
    if (callback != null) {
      callback(variabile);
    }
  }
}

// Widget di hosting che implementa l'interfaccia FunzioneDiCallback
class ModArgomentoActivity extends StatefulWidget {
  @override
  _ModArgomentoActivityState createState() => _ModArgomentoActivityState();
}

class _ModArgomentoActivityState extends State<ModArgomentoActivity>
    implements FunzioneDiCallback {
  late String argomentoSelezionato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ModArgomentoActivity"),
      ),
      body: Column(
        children: [
          Text("Argomento Selezionato: $argomentoSelezionato"),
          ArgomentoSingoloFragment(
            // Passa la funzione di callback al frammento
            onVariablePassed: passaVariabileAllActivity,
          ),
        ],
      ),
    );
  }

  // Funzione di callback per gestire l'argomento selezionato dal frammento
  @override
  void passaVariabileAllActivity(String variabile) {
    setState(() {
      argomentoSelezionato = variabile;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: ModArgomentoActivity(),
  ));
}
