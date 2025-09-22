import 'package:calorie_calculator/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getThemeMode() => _prefs.getBool(SharedPrefsKeys.isDarkMode) ?? false;

  Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool(SharedPrefsKeys.isDarkMode, isDarkMode);
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}