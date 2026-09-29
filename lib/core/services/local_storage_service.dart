import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences so features never import
/// shared_preferences directly. لو قررنا نستبدلها بـ Hive بعدين،
/// التعديل هيبقى في الملف ده بس.
class LocalStorageService {
  LocalStorageService(this._prefs);

  final SharedPreferences _prefs;

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clear() => _prefs.clear();
}
