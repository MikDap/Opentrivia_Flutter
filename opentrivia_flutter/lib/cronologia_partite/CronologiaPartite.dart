import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PartitaTerminata.dart';


class CronologiaPartite extends StatefulWidget {
  @override
  _CronologiaPartiteState createState() => _CronologiaPartiteState();
}

class _CronologiaPartiteState extends State<CronologiaPartite> {
  late final Map<int, PartitaTerminata> partiteList;
  late String uid;
  late DatabaseReference partiteTerminateRef;
  late PartitaTerminata partitaTerminata;

  @override
  void initState() {
    super.initState();
    partiteList = {};
    uid = FirebaseAuth.instance.currentUser!.uid;
    partiteTerminateRef = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(uid)
        .child('partite terminate');
    _loadPartiteTerminate();
  }

  void _loadPartiteTerminate() {
    partiteTerminateRef.onValue.listen((event) {
      DataSnapshot partite = event.snapshot;
      partiteList.clear();
      var position = 0;

      for (DataSnapshot difficolta in partite.children) {
        for (DataSnapshot partita in difficolta.children) {
          bool ritirato = false;
          bool avvRitirato = false;
          bool avvEsiste = false;
          var partitaRef = FirebaseDatabase.instance
              .ref()
              .child('users')
              .child(uid)
              .child('partite terminate')
              .child(difficolta.key.toString())
              .child(partita.key.toString());

          partitaRef.child('vista').set('si');

          for (DataSnapshot giocatore in partita.child('giocatori').children) {
            var giocatore1 = giocatore.key.toString();
            if (giocatore1 == uid) {
              if (giocatore.hasChild('ritirato')) {
                ritirato = true;
              }
            } else {
              if (giocatore.hasChild('ritirato')) {
                avvRitirato = true;
              }
              avvEsiste = true;

              var nomeAvv = giocatore.child('name').value.toString();
              var scoreMio = partita.child('esito').child('io').value.toString();
              var scoreAvv =
              partita.child('esito').child('avversario').value.toString();

              var partitaTer = PartitaTerminata(
                  nomeAvv, scoreMio, scoreAvv, ritirato, avvRitirato);
              partiteList[position] = partitaTer;
            }
          }

          if (!avvEsiste) {
            var nomeAvv = 'TI SEI RITIRATO';
            var scoreMio = partita.child('esito').child('io').value.toString();
            var scoreAvv =
            partita.child('esito').child('avversario').value.toString();

            var partitaTer = PartitaTerminata(
                nomeAvv, scoreMio, scoreAvv, ritirato, false);
            partiteList[position] = partitaTer;
          }
          else if(avvRitirato){ var nomeAvv = 'AVVERSARIO RITIRATO';
          var scoreMio = partita.child('esito').child('io').value.toString();
          var scoreAvv =
          partita.child('esito').child('avversario').value.toString();

          var partitaTer = PartitaTerminata(
              nomeAvv, scoreMio, scoreAvv, false,avvRitirato);
          partiteList[position] = partitaTer;
          }
          position++;
        }
      }

      setState(() {});
    }, onError: (Object? error) {
      // Handle error
    });
  }

  BoxDecoration setDrawable(String esito) {
    if (esito == 'sconfitta') {
      return BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10));
    }

    if (esito == 'pareggio') {
      return BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      );
    }

    if (esito == 'vittoria') {
      return BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      );
    }
    return BoxDecoration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cronologia Partite'),
      ),
      body: ListView.builder(
        itemCount: partiteList.length,
        itemBuilder: (context, position) {
          var partita = partiteList[position];
          if (partita != null) {
            return ListTile(
              title: Text(partita.nomeAvv,
                textAlign: TextAlign.center),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Score: ${partita.punteggioMio} - ${partita.punteggioAvv}',
                  textAlign: TextAlign.center),
                ],
              ),
              tileColor: coloraSfondoPartita(partita),
            );
          }
          return Container();
        },
      ),
    );
  }

  Color coloraSfondoPartita(PartitaTerminata partita) {
    var punteggioMio = int.parse(partita.punteggioMio);
    var punteggioAvv = int.parse(partita.punteggioAvv);
    var ritirato = partita.ritirato;
    var avvRitirato = partita.avvRitirato;
    if (ritirato) {
      return Colors.red.withOpacity(0.5);
    } else if (avvRitirato) {
      return Colors.green.withOpacity(0.5);
    } else {
      if (punteggioMio > punteggioAvv) {
        return Colors.green.withOpacity(0.5);
      } else if (punteggioMio < punteggioAvv) {
        return Colors.red.withOpacity(0.5);
      } else {
        return Colors.grey.withOpacity(0.5);
      }
    }
  }
}