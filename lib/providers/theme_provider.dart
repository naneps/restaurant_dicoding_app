import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/constants/key_storage.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  late final LocalStorageService _localStorageService;

  ThemeProvider() {
    _localStorageService = LocalStorageService();
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _localStorageService.saveString(
      KeyStorage.theme.name,
      themeMode.name,
    );
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
    }
    await _localStorageService.saveString(
      KeyStorage.theme.name,
      _themeMode.name,
    );
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    await _localStorageService.init();
    final String? savedTheme =
        _localStorageService.getString(KeyStorage.theme.name);

    _themeMode = switch (savedTheme) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system
    };
    notifyListeners();
  }
}
