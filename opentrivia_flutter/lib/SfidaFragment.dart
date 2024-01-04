import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:your_flutter_project/gioco/a_tempo/mod_atempo_activity.dart';
import 'package:your_flutter_project/gioco/argomento_singolo/mod_argomento_activity.dart';
import 'package:your_flutter_project/gioco/classica/mod_classica_activity.dart';

class SfidaFragment extends StatefulWidget {
  const SfidaFragment({Key? key}) : super(key: key);

  @override
  _SfidaFragmentState createState() => _SfidaFragmentState();
}

class _SfidaFragmentState extends State<SfidaFragment> {
  late LinearLayout sfidaContainer;
  late FirebaseDatabase database;
  late String uid;

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instance;
    uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          // Utilizza un FutureBuilder per gestire la logica asincrona
          future: fetchSfide(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Errore: ${snapshot.error}');
            } else {
              return sfidaContainer; // Visualizza il contenitore delle sfide
            }
          },
        ),
      ),
    );
  }

  Future<void> fetchSfide() async {
    sfidaContainer = LinearLayout(); // Inizializza il tuo sfidaContainer come desideri
    final sfideRef = database.reference('users').child(uid).child('sfide');

    try {
      DataSnapshot sfideSnapshot = await sfideRef.once();

      for (DataSnapshot sfida in sfideSnapshot.children) {
        processaSfida(sfida);
      }
    } catch (error) {
      throw Exception('Errore durante il recupero delle sfide: $error');
    }
  }

  void processaSfida(DataSnapshot sfida) {
    // La tua logica di elaborazione della singola sfida va qui
    // Puoi utilizzare i dati della sfida come sfida.key, sfida.child('modalita').value, ecc.

    // Ad esempio:
    String partita = sfida.key.toString();
    String nomeModalita = sfida.child('modalita').value.toString();
    String difficolta = sfida.child('difficolta').value.toString();
    String avvID = sfida.child('avversarioID').value.toString();
    String avvNome = sfida.child('avversario').value.toString();
    String topic = sfida.hasChild('topic') ? sfida.child('topic').value.toString() : 'nessuno';

    // Esegui il tuo codice UI qui, ad esempio:
    Widget gameView = buildGameView(avvNome, nomeModalita, difficolta, partita, topic);

    // Aggiungi gameView al tuo sfidaContainer
    sfidaContainer.addView(gameView);
  }

  Widget buildGameView(String avvNome, String nomeModalita, String difficolta, String partita, String topic) {
    return /* Costruisci qui il tuo widget gameView con i dati forniti */ Container();
  }
}
