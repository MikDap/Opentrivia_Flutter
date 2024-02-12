import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/Profilo.dart';
import 'package:opentrivia_flutter/cronologia_partite/CronologiaPartite.dart';
import 'package:opentrivia_flutter/menu/Difficolta.dart';

import '../lista_utenti/ListaUtenti.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedMenuItem = 'Opzione 1';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('OPENTRIVIA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent, // Imposta il colore di sfondo su trasparente
        elevation: 0, // Rimuovi l'ombra dalla AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3C4BEA), Color(0xFFFF7C34)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/images/menu.png',
                fit: BoxFit.fill,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.55),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE65100),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Difficolta()),
                      );
                    },
                    child: Text('Gioca',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
            // Aggiungi l'immagine sopra il pulsante Gioca
            Positioned(
              top: screenHeight * 0.20, // Imposta la posizione sull'asse y (puoi regolare questo valore in base alle tue esigenze)
              left: MediaQuery.of(context).size.width * 0.5 - 125.0,
              child: Image.asset(
                'assets/images/image.png',
                width: 250.0,
                height: 300.0,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 55, // Regola l'altezza dell'Header come preferisci
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1249B6), Color(0xFF81B9F6)],
                ),
              ),
              //child: DrawerHeader(
                //decoration: BoxDecoration(),
                child: Text(
                  'MENU',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              //),
            ),
            Divider( // Aggiungi questa linea per la divisione
              color: Colors.black,
              thickness: 3.0,
              height: 3.0,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7C34), Color(0xFF81B9F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Profilo'),
                    onTap: () {
                      setState(() {
                        selectedMenuItem = 'Profilo';
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profilo()),
                      );
                    },
                  ),
                  Divider( // Aggiungi questa linea per la divisione
                    color: Colors.black,
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  ListTile(
                    title: Text('Lista Utenti'),
                    onTap: () {
                      setState(() {
                        selectedMenuItem = 'Lista utenti';
                      });
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListaUtenti()),
                      );
                    },
                  ),
                  Divider( // Aggiungi questa linea per la divisione
                    color: Colors.black,
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  ListTile(
                    title: Text('Cronologia Partite'),
                    onTap: () {
                      setState(() {
                        selectedMenuItem = 'Cronologia Partite';
                      });
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CronologiaPartite()),
                      );
                      },
            ),
                  Divider( // Aggiungi questa linea per la divisione
                    color: Colors.black,
                    thickness: 1.0,
                    height: 1.0,
                  ),
          ],
        ),
      ),

    ],
    ),
    ),
    );
  }

}