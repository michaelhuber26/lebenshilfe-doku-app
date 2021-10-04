import 'package:flutter_tts/flutter_tts.dart';

class TtsApi {
  FlutterTts flutterTts = FlutterTts();

  void speak(String text) async {
    await flutterTts.speak(text);
  }

  void initTts() async {
    // iOS only
    await flutterTts.setSharedInstance(true);
    // iOS only
    await flutterTts
        .setIosAudioCategory(IosTextToSpeechAudioCategory.playAndRecord, [
      IosTextToSpeechAudioCategoryOptions.allowBluetooth,
      IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
      IosTextToSpeechAudioCategoryOptions.mixWithOthers
    ]);

    flutterTts.setLanguage('de-DE');
  }
}
