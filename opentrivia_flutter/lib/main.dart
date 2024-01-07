import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

import 'gioco/argomento_singolo/ArgomentoSingoloFragment.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'firebase_ui_oauth_google.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: "377360559767-8j881l3ab4uefpsas9o47in02cr69f0p.apps.googleusercontent.com",
    redirectUri: 'https://opentriviaflutter.firebaseapp.com/__/auth/handler'),
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'OpenTrivia',
      //mettere route

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
                Navigator.of(context).pushReplacementNamed('/home');
              }),

            ],

          );
        },
        '/profile': (context) => const ProfileScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const Home(),

      },
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(
                            appBar: AppBar(backgroundColor: Colors.red),
                            actions: [
                              SignedOutAction((context) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/sign-in');
                              }),
                            ],
                          )),
                );
              },
              color: Colors.white,
              icon: const Icon(Icons.account_box_sharp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}