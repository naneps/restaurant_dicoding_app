import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('initial theme mode should be light', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, ThemeMode.light);
    });

    test('toggleTheme should switch from light to dark', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('toggleTheme should switch from dark to light', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme(); // Switch to dark
      themeProvider.toggleTheme(); // Switch back to light
      expect(themeProvider.themeMode, ThemeMode.light);
    });
  });
}
