import 'dart:convert';
import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// uses shared_preferences to save settings when app is closed(not running)
class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static const _keyTtsSettings = 'TtsSettings';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setTtsSettings(TtsSettings settings) async {
    //convert TtsSettings Obj to JSON String and save
    String jsonTtsSettings = jsonEncode(settings);
    return await _preferences.setString(_keyTtsSettings, jsonTtsSettings);
  }

  static TtsSettings getTtsSettings() {
    var ttsSettings = TtsSettings();

    String jsonTtsSettings =
        _preferences.getString(_keyTtsSettings) ?? jsonEncode(ttsSettings);
    Map<String, dynamic> settingsMap = jsonDecode(jsonTtsSettings);
    TtsSettings settings = TtsSettings.fromJson(settingsMap);
    return settings;
  }
}
