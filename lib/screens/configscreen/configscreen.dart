import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Row(
            children: [Icon(Icons.speaker_phone), Text("TTS Einstellungen")],
          ))
        ],
      ),
    );
  }
}
