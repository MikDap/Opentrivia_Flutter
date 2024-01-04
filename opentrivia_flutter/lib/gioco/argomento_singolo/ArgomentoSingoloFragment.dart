import 'package:flutter/material.dart';

class ArgomentoSingoloFragment extends StatefulWidget {
  @override
  _ArgomentoSingoloFragmentState createState() => _ArgomentoSingoloFragmentState();
}

class _ArgomentoSingoloFragmentState extends State<ArgomentoSingoloFragment> {
  late ButtonStyle buttonStyle;
  late String topic;

  @override
  void initState() {
    super.initState();
    buttonStyle = ButtonStyle(
      // Aggiungi gli stili del pulsante qui, se necessario
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("culturaPop");
              },
              child: Text('Intrattenimento'),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("sport");
              },
              child: Text('Sport'),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("storia");
              },
              child: Text('Storia'),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("geografia");
              },
              child: Text('Geografia'),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("arte");
              },
              child: Text('Arte'),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                setTopic("scienze");
              },
              child: Text('Scienze'),
            ),
          ],
        ),
      ),
    );
  }

  void setTopic(String selectedTopic) {
    setState(() {
      topic = selectedTopic;
    });
    passVariableToActivity(topic);
  }

  void passVariableToActivity(String variable) {
    // Implementa la logica necessaria per passare la variabile all'Activity
  }
}