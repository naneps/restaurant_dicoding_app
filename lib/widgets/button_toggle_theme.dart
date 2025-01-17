import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_app/providers/theme_provider.dart';

class ButtonToggleTheme extends StatelessWidget {
  const ButtonToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: IconButton(
            icon: provider.themeMode == ThemeMode.light
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
            key: ValueKey(provider.themeMode),
            onPressed: () {
              provider.toggleTheme();
            },
          ),
        );
      },
    );
  }
}
