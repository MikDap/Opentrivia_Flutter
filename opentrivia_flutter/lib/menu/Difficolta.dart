import 'package:flutter/material.dart';
import '../gioco/argomento_singolo/SelezionaTopic.dart';

class Difficolta extends StatelessWidget {
ElevatedButton buildElevatedButton(String label, String difficulty, BuildContext context) {
return ElevatedButton(
onPressed: () => _impostaDifficoltaCpu(context, difficulty),
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFFFF5D00),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8.0),
side: BorderSide(
width: 2.0,
color: Color(0xFFFDFCFC),
),
),
),
child: SizedBox(
width: MediaQuery.of(context).size.width * 0.120,
height: MediaQuery.of(context).size.height * 0.085,
child: Center(
child: Text(
label,
style: TextStyle(
color: Colors.white,
fontSize: MediaQuery.of(context).size.width * 0.030,
),
),
),
),
);
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xDD0A013F),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
'Seleziona la difficoltà',
style: TextStyle(
fontSize: MediaQuery.of(context).size.width * 0.050,
fontFamily: 'Maven_Pro',
color: Colors.white,
),
),
SizedBox(height: 20.0),
buildElevatedButton('Facile', 'easy', context),
SizedBox(height: 10.0),
buildElevatedButton('Medio', 'medium', context),
SizedBox(height: 10.0),
buildElevatedButton('Difficile', 'hard', context),
SizedBox(height: 10.0),
],
),
),
);
}
void _impostaDifficoltaCpu(BuildContext context, String difficulty) {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => SelezionaTopic(difficulty: difficulty),
),
);
}
}

 