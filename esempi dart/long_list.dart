import 'package:flutter/material.dart';

void main() => runApp(MyApp(
	items: List<String>.generate(10000, (i) => 'Item $i'),
));

class MyApp extends StatelessWidget {
  final List<String> items;
  
  MyApp({Key? key, required this.items}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
      appBar: AppBar(
        title: Text("Long list"),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
          return ListTile('${items[index]}');
          },
        ),
      ),
    );
  }
}

