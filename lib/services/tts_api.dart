import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsApi {
  FlutterTts flutterTts = FlutterTts();

  /// Takes [text] and reads it loud (text to speech)
  void speak(String text) async {
    await flutterTts.speak(text);
  }

  /// initialises TTS (text to speech)
  /// android & iOS
  void initTts(TtsSettings ttsSettings) async {
    // iOS only
    await flutterTts.setSharedInstance(true);
    // iOS only
    await flutterTts
        .setIosAudioCategory(IosTextToSpeechAudioCategory.playAndRecord, [
      IosTextToSpeechAudioCategoryOptions.allowBluetooth,
      IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
      IosTextToSpeechAudioCategoryOptions.mixWithOthers
    ]);

    flutterTts.setLanguage(ttsSettings.language.toString());
    flutterTts.setVolume(ttsSettings.volume);
    flutterTts.setSpeechRate(ttsSettings.speechRate);
    flutterTts.setPitch(ttsSettings.pitch);
    if (!ttsSettings.isActivated) flutterTts.setVolume(0);
  }
}
