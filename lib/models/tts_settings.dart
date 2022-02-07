/// Object for easier Setup of the TTS API
///
/// makes it easier to communicate between the screens to setup tts
/// it holds all important settings for the usage of the TTS
class TtsSettings {
  String? language = 'de-DE';
  bool isActivated = true;
  double speechRate = 0.5;
  double volume = 0.5;
  double pitch = 1.0;

  TtsSettings();

  Map toJson() => {
        'language': language,
        'isActivated': isActivated,
        'speechRate': speechRate,
        'volume': volume,
        'pitch': pitch,
      };

  TtsSettings.fromJson(Map<String, dynamic> json)
      : language = json['language'],
        isActivated = json['isActivated'],
        speechRate = json['speechRate'],
        volume = json['volume'],
        pitch = json['pitch'];

  /// returns TtsSettings object as a string
  /// with layout: 'Language: ... , isActivated: ... '
  @override
  String toString() {
    return '{Language: ${this.language}, isActivated: ${this.isActivated}}';
  }
}
