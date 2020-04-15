//Packages Import
import 'package:flutter/material.dart';

//In files import
import './state_managers/root_states.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock & Sentiment',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        scaffoldBackgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),

  

      home: RootsStates(),
    );
  }
}
