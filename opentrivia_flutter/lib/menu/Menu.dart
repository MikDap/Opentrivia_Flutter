import 'package:flutter/material.dart';
import 'package:opentrivia_flutter/menu/Difficolta.dart'; // Assicurati di importare il tuo file Dart


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedMenuItem = 'Opzione 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      title: Text('OPENTRIVIA'),
    ),
    body: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/landscape.jpg'),
fit:BoxFit.fill
    ),
    ),
      child: Stack(
        children: [
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

