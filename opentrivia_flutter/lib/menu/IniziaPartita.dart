import 'package:flutter/material.dart';

class IniziaPartita extends StatefulWidget {
  @override
  _IniziaPartitaState createState() => _IniziaPartitaState();
}

class _IniziaPartitaState extends State<IniziaPartita> {
  late Button cercaPartitaButton;
  late TextView selezioneAvversario;
  late RecyclerView recyclerView;
  late String selezione;
  late String avversarioID;
  late String avversarioNome;
  final String uid = FirebaseAuth.instance.currentUser?.uid.toString();
  final DatabaseReference amiciRef = FirebaseDatabase.instance.reference().child("users").child(uid).child("amici");
  final Map<String, String> friendsList = {};
  late IniziaPartitaAdapter adapter;

  @override
  void initState() {
    super.initState();
    adapter = IniziaPartitaAdapter(friendsList, this);
  }

  @override
  Widget build(BuildContext context) {
    final modalita = ModalRoute.of(context)!.settings.arguments as String?;
    final difficolta = ModalRoute.of(context)!.settings.arguments as String?;
    final selezione = ModalRoute.of(context)!.settings.arguments as String?;
    if (selezione != null) {
      this.selezione = selezione;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Inizia Partita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToGame(context, modalita, difficolta, selezione);
              },
              child: Text('Inizia Partita'),
            ),
            Text('Avversario: $selezioneAvversario'),
            Visibility(
              visible: selezione == "casuale" ? false : true,
              child: RecyclerView.builder(
                itemCount: friendsList.length,
                itemBuilder: (context, index) {
                  final amicoId = friendsList.keys.toList()[index];
                  final amico = friendsList[amicoId];
                  return ListTile(
                    title: Text(amico!),
                    onTap: () {
                      nomeAvversario(amico);
                      avversarioID = amicoId;
                      avversarioNome = amico;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(BuildContext context, String modalita, String difficolta, String selezione) {
    late Intent intent;
    switch (modalita) {
      case "classica":
        intent = Intent(context, ModClassicaActivity::class.java);
        break;
      case "argomento singolo":
        intent = Intent(context, ModArgomentoActivity::class.java);
        break;
      case "a tempo":
        intent = Intent(context, ModATempoActivity::class.java);
        break;
    }

    if (selezione == "casuale") {
      intent.putExtra("difficolta", difficolta);
      intent.putExtra("avversario", "casuale");
