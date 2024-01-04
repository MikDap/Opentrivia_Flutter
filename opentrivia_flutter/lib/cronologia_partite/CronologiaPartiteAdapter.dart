import 'package:flutter/material.dart';

import 'CronologiaPartite.dart';

class CronologiaPartiteAdapter extends StatelessWidget {
  final Map<int, PartitaTerminata> partiteList;
  final CronologiaPartite cronologiaPartite;

  CronologiaPartiteAdapter(this.partiteList, this.cronologiaPartite);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: partiteList.length,
      itemBuilder: (context, position) {
        var partita = partiteList[position];
        if (partita != null) {
          return ListTile(
            title: Text(partita.nomeAvv),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Score: ${partita.punteggioMio} - ${partita.punteggioAvv}'),
                Text('Modalità: ${scriviModalita(partita)}'),
              ],
            ),
            tileColor: coloraSfondoPartita(partita),
          );
        }
        return Container();
      },
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

  String scriviModalita(PartitaTerminata partita) {
    switch (partita.modalita) {
      case 'classica':
        return 'Classica';
      case 'argomento singolo':
        return 'Argomento Singolo';
      case 'a tempo':
        return 'A Tempo';
      default:
        return '';
    }
  }
}

class PartitaTerminata {
  final String nomeAvv;
  final String punteggioMio;
  final String punteggioAvv;
  final String modalita;
  final bool ritirato;
  final bool avvRitirato;

  PartitaTerminata(this.nomeAvv, this.punteggioMio, this.punteggioAvv, this.modalita, this.ritirato, this.avvRitirato);
}
