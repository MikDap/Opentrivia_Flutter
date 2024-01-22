import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/menu/Difficolta.dart';

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
        title: Text('OPENTRIVIA'),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/images/menu.png',
                width: 24.0,
                height: 24.0,
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
            image: AssetImage('assets/images/landscape.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE65100),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    ),
                    onPressed: () {
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
            // Aggiungi l'immagine sopra il pulsante Gioca
            Positioned(
              top: screenHeight * 0.25, // Imposta la posizione sull'asse y (puoi regolare questo valore in base alle tue esigenze)
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