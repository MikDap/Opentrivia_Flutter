import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/menu/Difficolta.dart'; // Assicurati di importare il tuo file Dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedMenuItem = 'Opzione 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xDD0A013F),
      appBar: AppBar(
        title: Text('OPENTRIVIA'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/download.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Naviga verso la SchermataGioco quando il bottone viene premuto
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Difficolta()),
                    );
                  },
                  child: Text('Gioca'),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('Profilo'),
              onTap: () {
                setState(() {
                  selectedMenuItem = 'Profilo';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Lista Utenti'),
              onTap: () {
                setState(() {
                  selectedMenuItem = 'Lista utenti';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Statistiche'),
              onTap: () {
                setState(() {
                  selectedMenuItem = 'Statistiche';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
