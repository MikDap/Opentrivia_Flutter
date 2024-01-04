import 'package:flutter/material.dart';

class OpenTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OpenTriviaHomePage(),
    );
  }
}

class OpenTriviaHomePage extends StatefulWidget {
  @override
  _OpenTriviaHomePageState createState() => _OpenTriviaHomePageState();
}

class _OpenTriviaHomePageState extends State<OpenTriviaHomePage> {
  final userMethods = UserMethods(); // Assicurati di implementare UserMethods

  @override
  void initState() {
    super.initState();
    signInUser();
  }

  Future<void> signInUser() async {
    // Implementa la logica di accesso dell'utente qui
    // Puoi utilizzare pacchetti come `firebase_auth` per gestire l'autenticazione
    // Esempio:
    // await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Trivia'),
      ),
      body: Center(
        child: Text('Welcome to Open Trivia App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Chat'),
              onTap: () {
                // Naviga verso la schermata di chat
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Inbox'),
              onTap: () {
                // Gestisci l'evento per l'item "Inbox"
              },
            ),
            ListTile(
              title: Text('Statistiche'),
              onTap: () {
                // Naviga verso la schermata delle statistiche
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticheScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Lista Amici'),
              onTap: () {
                // Naviga verso la schermata della lista degli amici
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaAmiciScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}

class StatisticheScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiche'),
      ),
      body: Center(
        child: Text('Statistiche Screen'),
      ),
    );
  }
}

class ListaAmiciScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Amici'),
      ),
      body: Center(
        child: Text('Lista Amici Screen'),
      ),
    );
  }
}

// Aggiungi qui la tua implementazione della classe UserMethods
class UserMethods {
  // Implementa i metodi necessari per l'autenticazione e la gestione dell'utente
}

void main() {
  runApp(OpenTriviaApp());
}
