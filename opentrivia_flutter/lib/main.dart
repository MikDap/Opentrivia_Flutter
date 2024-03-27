

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:opentrivia_flutter/menu/Menu.dart';
import 'firebase_options.dart';


import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'firebase_ui_oauth_google.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: "377360559767-8j881l3ab4uefpsas9o47in02cr69f0p.apps.googleusercontent.com",
    redirectUri: 'https://opentriviaflutter.firebaseapp.com/__/auth/handler'),
  ]);
  runApp(const MyApp());

  }


class MyApp extends StatelessWidget {
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'OpenTrivia',

      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,


      initialRoute:
      FirebaseAuth.instance.currentUser == null ? '/sign in' : '/home',
      routes: {
        '/sign in': (context) {
          return SignInScreen(

            actions: [
              ForgotPasswordAction((context, email) {
                Navigator.of(context).pushNamed(
                  '/forgot-password',
                  arguments: {'email': email},
                );
              }),
              AuthStateChangeAction<SignedIn>((context, _) {
                Navigator.of(context).pushReplacementNamed('/home');
              }),
              AuthStateChangeAction<UserCreated>((context, _) {
              User? user = FirebaseAuth.instance.currentUser;
              final DatabaseReference databaseRef = database.ref();
               if (user != null) {
               databaseRef.child('users').child(user.uid).set({
                 'name': user.displayName,
                 });
               print('display+${user.displayName}');
               if(user.displayName == null ){
                 int randomNumber = generateRandomNumber();
                String nomeUtente = 'user$randomNumber';

                 FirebaseAuth.instance.currentUser!.updateDisplayName(nomeUtente).then((_) {
                   databaseRef.child('users').child(user.uid).set({
                   'name': nomeUtente,
                 });
                   print("Display name updated successfully!");
                 }).catchError((error) {
                   print("Failed to update display name: $error");
                 });


               }}

                Navigator.of(context).pushReplacementNamed('/home');
              }),

            ],

          );

    },
        '/profile': (context) => const ProfileScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => Menu(),

     },
    );
   }
  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10000);
  }
}

