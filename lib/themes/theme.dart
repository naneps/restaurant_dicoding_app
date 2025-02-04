import "package:flutter/material.dart";

class ColorFamily {
  final Color color;

  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  List<ExtendedColor> get extendedColors => [];

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorScheme.surface,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurface,
            selectedIconTheme: IconThemeData(
              color: colorScheme.primary,
            ),
            unselectedIconTheme: IconThemeData(
              color: colorScheme.onSurface,
            ),
            selectedLabelStyle: textTheme.labelMedium,
            unselectedLabelStyle: textTheme.labelSmall,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            elevation: 0),
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.onSurface,
              width: 0.5,
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            backgroundColor: colorScheme.surface,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
            textStyle: textTheme.labelMedium,
          ),
        ),
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: colorScheme.onSurface,
          textColor: colorScheme.onSurface,
          collapsedIconColor: colorScheme.onSurface,
          collapsedTextColor: colorScheme.onSurface,
          collapsedBackgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
              side: BorderSide(
            style: BorderStyle.none,
          )),
        ),
        canvasColor: colorScheme.surface,
        chipTheme: ChipThemeData(
          backgroundColor: colorScheme.surfaceContainer,
          secondaryLabelStyle: textTheme.labelMedium,
          selectedColor: colorScheme.primaryContainer,
          side: BorderSide(
            color: colorScheme.onSurface,
            width: 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        switchTheme: SwitchThemeData(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            thumbColor: WidgetStateProperty.all(colorScheme.primary),
            trackColor: WidgetStateProperty.all(colorScheme.surfaceContainer),
            trackOutlineColor: WidgetStateProperty.all(
              colorScheme.onSurfaceVariant,
            ),
            overlayColor: WidgetStateProperty.all(
              colorScheme.onSurfaceVariant,
            )),
      );

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 113, 129, 223),
      surfaceTint: Color(0xffc1c1ff),
      onPrimary: Color.fromARGB(255, 219, 230, 244),
      primaryContainer: Color.fromARGB(255, 83, 83, 115),
      onPrimaryContainer: Color.fromARGB(255, 236, 239, 255),
      secondary: Color(0xffc6c4dd),
      onSecondary: Color(0xff2e2f42),
      secondaryContainer: Color(0xff454559),
      onSecondaryContainer: Color(0xffe2e0f9),
      tertiary: Color(0xffe9b9d3),
      onTertiary: Color(0xff46263a),
      tertiaryContainer: Color(0xff5f3c51),
      onTertiaryContainer: Color(0xffffd8ec),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color.fromARGB(255, 8, 8, 16),
      onSurface: Color(0xffe4e1e9),
      onSurfaceVariant: Color(0xffc8c5d0),
      outline: Color(0xff918f9a),
      outlineVariant: Color(0xff47464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff585992),
      primaryFixed: Color(0xffe1dfff),
      onPrimaryFixed: Color(0xff13144a),
      primaryFixedDim: Color(0xffc1c1ff),
      onPrimaryFixedVariant: Color(0xff404178),
      secondaryFixed: Color(0xffe2e0f9),
      onSecondaryFixed: Color(0xff1a1a2c),
      secondaryFixedDim: Color(0xffc6c4dd),
      onSecondaryFixedVariant: Color(0xff454559),
      tertiaryFixed: Color(0xffffd8ec),
      onTertiaryFixed: Color(0xff2e1125),
      tertiaryFixedDim: Color(0xffe9b9d3),
      onTertiaryFixedVariant: Color(0xff5f3c51),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39383f),
      surfaceContainerLowest: Color(0xff0e0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff2a292f),
      surfaceContainerHighest: Color(0xff35343a),
    );
  }

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 45, 46, 70),
      surfaceTint: Color(0xff585992),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color.fromARGB(255, 34, 36, 49),
      onPrimaryContainer: Color.fromARGB(255, 243, 243, 255),
      secondary: Color(0xff5d5c72),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe2e0f9),
      onSecondaryContainer: Color(0xff1a1a2c),
      tertiary: Color(0xff795369),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd8ec),
      onTertiaryContainer: Color(0xff2e1125),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color.fromARGB(255, 248, 249, 255),
      onSurface: Color(0xff1b1b21),
      onSurfaceVariant: Color(0xff47464f),
      outline: Colors.grey.shade300,
      outlineVariant: Color(0xffc8c5d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inversePrimary: Color(0xffc1c1ff),
      primaryFixed: Color(0xffe1dfff),
      onPrimaryFixed: Color(0xff13144a),
      primaryFixedDim: Color(0xffc1c1ff),
      onPrimaryFixedVariant: Color(0xff404178),
      secondaryFixed: Color(0xffe2e0f9),
      onSecondaryFixed: Color(0xff1a1a2c),
      secondaryFixedDim: Color(0xffc6c4dd),
      onSecondaryFixedVariant: Color(0xff454559),
      tertiaryFixed: Color(0xffffd8ec),
      onTertiaryFixed: Color(0xff2e1125),
      tertiaryFixedDim: Color(0xffe9b9d3),
      onTertiaryFixedVariant: Color(0xff5f3c51),
      surfaceDim: Color(0xffdcd9e0),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fa),
      surfaceContainer: Color.fromARGB(255, 255, 255, 255),
      surfaceContainerHigh: Color(0xffeae7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }
}
