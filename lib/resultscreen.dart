import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<int>;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Übersicht über die ausgewählten Piktogramme',
              style: TextStyle(fontSize: 40),
            ),
            Column(
              children: [
                Text(
                  'Ausgewählte Piktogramme der Reihenfolge nach\n',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  args.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            // for (var i in args) Text(i.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'GO BACK TO LOGIN',
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
