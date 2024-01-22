//schermata vittoria ,sconfitta,pareggio
//questa è la risposta corretta
//update stat topic
//updaterisposte

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

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
      case "culturaPop":
        categoria = getRandomTopic(categorieCulturaPop);
        break;
      case "sport":
        categoria = "21";
        break;
      case "storia":
        categoria = "23";
        break;
      case "geografia":
        categoria = "22";
        break;
      case "arte":
        categoria = "25";
        break;
      case "scienze":
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
}