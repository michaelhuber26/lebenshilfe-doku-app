import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _ttsActive = true;

  void _ttsActiveChange(value) {
    setState(() {
      _ttsActive = value;
      print(_ttsActive);
    });
  }

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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.speaker_phone),
                    Text(
                      "TTS Einstellungen",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "TTS (Text to Speech)",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Switch(value: _ttsActive, onChanged: _ttsActiveChange)
                ],
              ),
              Divider(
                indent: 16,
                endIndent: 16,
                color: Colors.grey[300],
                thickness: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
