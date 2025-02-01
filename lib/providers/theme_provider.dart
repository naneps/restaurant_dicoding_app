import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_app/services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final LocalStorageService _localStorageService = LocalStorageService();

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      await _localStorageService.saveString('theme', 'dark');
    } else {
      _themeMode = ThemeMode.light;
      await _localStorageService.saveString('theme', 'light');
    }
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    await _localStorageService.init();
    final String? savedTheme = _localStorageService.getString('theme');

    if (savedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
