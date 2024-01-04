import 'package:flutter/material.dart';

class CronologiaPartite extends StatefulWidget {
  @override
  _CronologiaPartiteState createState() => _CronologiaPartiteState();
}

class _CronologiaPartiteState extends State<CronologiaPartite> {
  late Map<int, PartitaTerminata> partiteList;
  late CronologiaPartiteAdapter adapter;
  late String uid;
  late DatabaseReference partiteTerminateRef;

  @override
  void initState() {
    super.initState();
    partiteList = {};
    adapter = CronologiaPartiteAdapter(partiteList, this);
    uid = FirebaseAuth.instance.currentUser!.uid;
    partiteTerminateRef = FirebaseDatabase.instance.reference.child('users').child(uid).child('partite terminate');
    _loadPartiteTerminate();
  }

  void _loadPartiteTerminate() {
    partiteTerminateRef.onValue.listen((event) {
      DataSnapshot partite = event.snapshot;
      partiteList.clear();
      var position = 0;

      for (DataSnapshot modalita in partite.children) {
        for (DataSnapshot difficolta in modalita.children) {
          for (DataSnapshot partita in difficolta.children) {
            bool ritirato = false;
            bool avvRitirato = false;
            bool avvEsiste = false;
            var partitaRef = FirebaseDatabase.instance.reference.child('users').child(uid).child('partite terminate').child(
                modalita.key.toString()).child(difficolta.key.toString()).child(partita.key.toString());

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
                var scoreAvv = partita.child('esito').child('avversario').value.toString();

                var partitaTer = PartitaTerminata(nomeAvv, scoreMio, scoreAvv, modalita.key.toString(), ritirato, avvRitirato);
                partiteList[position] = partitaTer;
              }
            }

            if (!avvEsiste) {
              var nomeAvv = '/';
              var scoreMio = partita.child('esito').child('io').value.toString();
              var scoreAvv = partita.child('esito').child('avversario').value.toString();

              var partitaTer = PartitaTerminata(nomeAvv, scoreMio, scoreAvv, modalita.key.toString(), ritirato, false);
              partiteList[position] = partitaTer;
            }
            position++;
          }
        }
      }
      adapter.notifyDataSetChanged();
    }, onError: (Object? error) {
      // Handle error
    });
  }

  void setDrawable(CronologiaPartiteAdapter.ViewHolder holder, String esito) {
    if (esito == 'sconfitta') {
      holder.itemView.background = BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      );
    }

    if (esito == 'pareggio') {
      holder.itemView.background = BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      );
    }

    if (esito == 'vittoria') {
      holder.itemView.background = BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: partiteList.length,
                itemBuilder: (context, index) {
                  var partita = partiteList[index]!;
                  return ListTile(
                    title: Text(partita.nomeAvv),
                    subtitle: Text('Score: ${partita.scoreMio} - ${partita.scoreAvv}'),
                    tileColor: Colors.grey[200],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartitaTerminata {
  final String nomeAvv;
  final String scoreMio;
  final String scoreAvv;
  final String modalita;
  final bool ritirato;
  final bool avvRitirato;

  PartitaTerminata(this.nomeAvv, this.scoreMio, this.scoreAvv, this.modalita, this.ritirato, this.avvRitirato);
}

class CronologiaPartiteAdapter extends StatelessWidget {
  final Map<int, PartitaTerminata> partiteList;
