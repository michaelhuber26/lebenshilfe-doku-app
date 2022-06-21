import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:flutter_tts/flutter_tts.dart';

// NOT USED ANYMORE
class TtsApi {
  FlutterTts flutterTts = FlutterTts();

  /// Takes [text] and reads it loud (text to speech)
  void speak(String text) async {
    await flutterTts.speak(text);
  }

  void stop() {
    flutterTts.stop();
  }

  /// initialises TTS (text to speech)
  /// android & iOS
  void initTts(TtsSettings ttsSettings) async {
    print(ttsSettings);

    // // iOS only
    // await flutterTts.setSharedInstance(true);
    // // iOS only
    // await flutterTts
    //     .setIosAudioCategory(IosTextToSpeechAudioCategory.playAndRecord, [
    //   IosTextToSpeechAudioCategoryOptions.allowBluetooth,
    //   IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
    //   IosTextToSpeechAudioCategoryOptions.mixWithOthers
    // ]);

    await flutterTts.setLanguage(ttsSettings.language.toString());
    await flutterTts.setVolume(ttsSettings.volume);
    await flutterTts.setSpeechRate(ttsSettings.speechRate);
    await flutterTts.setPitch(ttsSettings.pitch);
    if (!ttsSettings.isActivated) await flutterTts.setVolume(0);

    print("finished initTts!");
  }
}
