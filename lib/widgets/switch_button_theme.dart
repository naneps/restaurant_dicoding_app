import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';

class SwitchButtonTheme extends StatelessWidget {
  const SwitchButtonTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, provider, child) {
        return AnimatedToggleSwitch.rolling(
          current: provider.themeMode,
          values: ThemeMode.values,
          iconBuilder: (value, foreground) {
            return Icon(
              value.iconData,
              color: Theme.of(context).colorScheme.primary,
            );
          },
          onChanged: (value) {
            provider.setTheme(value);
          },
          indicatorIconScale: 1.2,
          borderWidth: 1.5,
          style: ToggleStyle(
              borderRadius: BorderRadius.circular(50),
              indicatorColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              borderColor: Theme.of(context).colorScheme.outline,
              indicatorGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        );
      },
    );
  }
}

extension ThemeModeExtension on ThemeMode {
  IconData get iconData {
    switch (this) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings;
    }
  }
}
