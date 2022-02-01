import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

  String? dropdownValue;
  double volume = 0.5;
  double rate = 0.5;
  double pitch = 1.0;

  FlutterTts flutterTts = FlutterTts();
  List<String> languages = [];

  Future _getLanguages() async {
    dynamic sysLanguages = await flutterTts.getLanguages;
    if (sysLanguages != null) {
      for (String lang in sysLanguages) {
        languages.add(lang);
      }
      languages.sort();

      setState(() => languages);
    }
  }

  @override
  void initState() {
    super.initState();
    _getLanguages();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Sprache",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    hint: Text("Sprache"),
                    items: languages.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Lautstärke (Text to Speech)",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Slider(
                      value: volume,
                      onChanged: (newVolume) {
                        setState(() => volume = newVolume);
                      },
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: "Volume: $volume"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Geschwindigkeit (Text to Speech)",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Slider(
                    value: rate,
                    onChanged: (newRate) {
                      setState(() => rate = newRate);
                    },
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: "Rate: $rate",
                    activeColor: Colors.green,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Pitch (Text to Speech)",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Slider(
                    value: pitch,
                    onChanged: (newPitch) {
                      setState(() => pitch = newPitch);
                    },
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    label: "Pitch: $pitch",
                    activeColor: Colors.red,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
