import 'package:flutter/material.dart';
import './questionscreen.dart';
import './loginscreen.dart';
import './resultscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange[900]),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/question': (context) => QuestionScreen(),
        '/result': (context) => ResultScreen()
      },
    );
  }
}
