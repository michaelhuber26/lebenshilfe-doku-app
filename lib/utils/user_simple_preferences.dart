import 'dart:convert';
import 'package:dokumentation_lh/models/tts_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyTtsSettings = 'TtsSettings';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTtsSettings(TtsSettings settings) async {
    //convert TtsSettings Obj to JSON String and save
    String jsonTtsSettings = jsonEncode(settings);
    return await _preferences!.setString(_keyTtsSettings, jsonTtsSettings);
  }

  static TtsSettings getTtsSettings() {
    String? jsonTtsSettings = _preferences!.getString(_keyTtsSettings);
    Map<String, dynamic> settingsMap = jsonDecode(jsonTtsSettings!);
    TtsSettings settings = TtsSettings.fromJson(settingsMap);
    return settings;
  }
}
