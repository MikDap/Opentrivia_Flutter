import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome")
        ),
        body: Center(
          child:RandomWords()
        )
      )
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>{

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context){
    //final wordPair = WordPair.random();
    //return Text(wordPair.asCamelCase);
    return _buildSuggestions();
  }


  Widget _buildSuggestions(){
    return ListView.builder(
        itemBuilder: (BuildContext context, int i){
          if (i.isOdd)
            return Divider();

          final int index = i~/2;

          if(index>=_suggestions.length)
            _suggestions.addAll(generateWordPairs().take(10));

          return ListTile(
              title:Text(_suggestions[index].asCamelCase,
              style:_biggerFont),
          );
        });
  }
}

