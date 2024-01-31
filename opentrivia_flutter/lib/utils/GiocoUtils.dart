//schermata vittoria ,sconfitta,pareggio
//questa è la risposta corretta
//update stat topic
//updaterisposte

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/gioco/AttendiTurno.dart';
import 'package:opentrivia_flutter/gioco/Pareggio.dart';
import 'package:opentrivia_flutter/gioco/Sconfitta.dart';

import '../gioco/Vittoria.dart';

class GiocoUtils {


  String getCategoria(String topic) {
    late String categoria;

    List<String> categorieCulturaPop = [
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "29",
      "31",
      "32"
    ];
    List<String> categorieScienze = ["17", "18", "19", "30"];

    switch (topic) {
      case "CulturaPop":
        categoria = getRandomTopic(categorieCulturaPop);
        break;
      case "Sport":
        categoria = "21";
        break;
      case "Storia":
        categoria = "23";
        break;
      case "Geografia":
        categoria = "22";
        break;
      case "Arte":
        categoria = "25";
        break;
      case "Scienze":
        categoria = getRandomTopic(categorieScienze);
        break;
    }
    return categoria;
  }

  String getRandomTopic(List<String> topics) {
    Random random = Random();
    return topics[random.nextInt(topics.length)];
  }


  bool questaELaRispostaCorretta(String risposta, String rispostaCorretta) {
    if (risposta == rispostaCorretta) {
      return true;
    } else {
      return false;
    }
  }
  void schermataAttendi(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => AttendiTurno()),
      );
    });
  }

  void schermataVittoria(
   BuildContext context,
      String nomeAvv,
      Text scoreMio,
      Text scoreAvv,
      ) {
    Future.delayed(Duration(milliseconds: 500), () {print('vitt');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Vittoria(
           nomeAvv: nomeAvv,
            scoreMio: scoreMio,
            scoreAvv: scoreAvv,
          ),
        ),
      );
    });
  }


  void schermataPareggio(
      BuildContext context,
       String nomeAvv,
       Text scoreMio,
       Text scoreAvv,

      ) {
    Future.delayed(Duration(milliseconds: 500), () {print('pare');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Pareggio(
            nomeAvv: nomeAvv,
           scoreMio: scoreMio,
            scoreAvv: scoreAvv,
          ),
        ),
      );
    });
  }

  void schermataSconfitta(
      BuildContext context,
       String nomeAvv,
       Text scoreMio,
       Text scoreAvv,
      ) {
    Future.delayed(Duration(milliseconds: 500), () {print('scon');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Sconfitta(
            nomeAvv: nomeAvv,
            scoreMio: scoreMio,
            scoreAvv: scoreAvv,
          ),
        ),
      );
    });
  }




}