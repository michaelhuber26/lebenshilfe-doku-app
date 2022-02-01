/// Object for easier Setup of the TTS API
///
/// makes it easier to communicate between the screens to setup tts
/// it holds all important settings for the usage of the TTS
class TtsSettings {
  String language;
  String voice = "";
  bool isActivated = false;
  double speechRate = 1.0;
  double volume = 1.0;

  TtsSettings({required this.language, required this.isActivated});

  /// returns TtsSettings object as a string
  /// with layout: 'Language: ... , isActivated: ... '
  @override
  String toString() {
    return '{Language: ${this.language}, isActivated: ${this.isActivated}}';
  }
}
