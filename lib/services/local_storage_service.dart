import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  static SharedPreferences? _preferences;
  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  Future<void> clear() async {
    await _preferences?.clear();
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }
}
