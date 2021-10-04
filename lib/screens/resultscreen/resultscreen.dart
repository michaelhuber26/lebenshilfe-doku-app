import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/questions.dart';
import 'local_widgets/body.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Question;

    return Scaffold(
      appBar: AppBar(
        title: Text("ResultScreen"),
      ),
      body: Body(args: args),
    );
  }
}
