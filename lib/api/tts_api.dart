import 'package:flutter_tts/flutter_tts.dart';

class TtsApi {
  FlutterTts flutterTts = FlutterTts();

  void speak(String text) async {
    flutterTts.setLanguage('de-DE');
    await flutterTts.speak(text);
  }
}
