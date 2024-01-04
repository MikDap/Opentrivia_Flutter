import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class StatFragment extends StatefulWidget {
  @override
  _StatFragmentState createState() => _StatFragmentState();
}

class _StatFragmentState extends State<StatFragment> {
  late TextView storia;
  late Guideline storiaPerc;
  late TextView geografia;
  late Guideline geografiaPerc;
  late TextView arte;
  late Guideline artePerc;
  late TextView sport;
  late Guideline sportPerc;
  late TextView intrattenimento;
  late Guideline intrattenimentoPerc;
  late TextView scienze;
  late Guideline scienzePerc;
  late FirebaseDatabase database;

  @override
  void initState() {
    super.initState();
    storia = TextView();
    storiaPerc = Guideline();
    geografia = TextView();
    geografiaPerc = Guideline();
    arte = TextView();
    artePerc = Guideline();
    sport = TextView();
    sportPerc = Guideline();
    intrattenimento = TextView();
    intrattenimentoPerc = Guideline();
    scienze = TextView();
    scienzePerc = Guideline();
    database = FirebaseDatabase.instance;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Sostituisci con la tua funzione asincrona per ottenere i dati
      future: initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildUI();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> initData() async {
    // Inizializza i dati qui
    await controllaStatistiche();
  }

  Widget buildUI() {
    return Scaffold(
      body: Column(
        children: [
          // Includi qui i tuoi elementi UI
          storia,
          storiaPerc,
          geografia,
          geografiaPerc,
          arte,
          artePerc,
          sport,
          sportPerc,
          intrattenimento,
          intrattenimentoPerc,
          scienze,
          scienzePerc,
        ],
      ),
    );
  }

  Future<void> controllaStatistiche() async {
    var uid = FirebaseAuth.instance.currentUser?.uid.toString();
    var statRef = database.reference().child("users").child(uid).child("stat");

    statRef.onValue.listen((event) {
      DataSnapshot statistiche = event.snapshot;
      for (DataSnapshot topic1 in statistiche.children) {
        var argomento = topic1.key.toString();

        controllaTopic(argomento, (topic, topicPerc) {
          var percentualeRiposte =
          topic1.child("%risposteCorrette").value.toString().toFloat();

          var floatPerc = percentualeRiposte / 100;

          setState(() {
            var params = topicPerc.layoutParams as ConstraintLayout.LayoutParams;
            params.guidePercent = floatPerc;

            topicPerc.layoutParams = params;
            var context = activity?.applicationContext;
            var text = context?.getString(
                R.string.argomento_percentuale, argomento,
                percentualeRiposte.toInt().toString());
            topic.text = text;
          });
        });
      }
    });
  }

  void controllaTopic(
      String argomento, void Function(TextView, Guideline) callback) {
    var topic = storia;
    var topicPerc = storiaPerc;

    switch (argomento) {
      case "storia":
        topic = storia;
        topicPerc = storiaPerc;
        break;
      case "sport":
        topic = sport;
        topicPerc = sportPerc;
        break;
      case "geografia":
        topic = geografia;
        topicPerc = geografiaPerc;
        break;
      case "arte":
        topic = arte;
        topicPerc = artePerc;
        break;
      case "scienze":
        topic = scienze;
        topicPerc = scienzePerc;
        break;
      case "culturaPop":
        topic = intrattenimento;
        topicPerc = intrattenimentoPerc;
        break;
    }

    callback(topic, topicPerc);
  }
}
