import 'package:flutter/material.dart';

class CaricamentoFragment extends StatefulWidget {
  const CaricamentoFragment({Key? key}) : super(key: key);

  @override
  _CaricamentoFragmentState createState() => _CaricamentoFragmentState();
}

class _CaricamentoFragmentState extends State<CaricamentoFragment> {
  String? param1;
  String? param2;

  @override
  void initState() {
    super.initState();
    // Ottieni i parametri iniziali qui, se necessario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caricamento Fragment'),
      ),
      body: Center(
        child: Text('Contenuto del fragment'),
      ),
    );
  }
}
