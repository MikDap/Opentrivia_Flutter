import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'gioco/argomento_singolo/ArgomentoSingoloFragment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenTrivia',
      //mettere route
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return SignInScreen(); // Schermata di accesso se l'utente non è autenticato
          }
          return MainMenuScreen(user); // Schermata principale con il menu se l'utente è autenticato
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      // Esegui qui la logica post-autenticazione se necessario
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accedi')),
      body: Center(
        child: ElevatedButton(
          onPressed: _signIn,
          child: Text('Accedi'),
        ),
      ),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  final User user;

  MainMenuScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Azione per navigare alla schermata di chat
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Text('Chat'),
            ),
            // Aggiungi altri pulsanti per altre schermate
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
      appBar: AppBar(title: Text('Chat')),
      body: Center(
        child: Text('Schermata di chat'),
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

