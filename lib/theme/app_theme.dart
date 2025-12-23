import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color.fromARGB(255, 234, 230, 230),
      primaryColor: const Color.fromARGB(255, 108, 179, 122),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 108, 179, 122),
        foregroundColor: Color.fromARGB(255, 234, 230, 230),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 108, 179, 122),
        foregroundColor: Color.fromARGB(255, 234, 230, 230),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: const Color.fromARGB(255, 234, 230, 230),
          iconColor: Colors.black,
          iconSize: 24,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black, width: 2)),
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 108, 179, 122),
        secondary: Color.fromARGB(255, 0, 119, 255),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        surface: Color.fromARGB(255, 234, 230, 230),
        onSurface: Colors.black,
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          displaySmall: TextStyle(color: Colors.black),
          headlineLarge: TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.black),
          headlineSmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black),
          bodyLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          labelLarge: TextStyle(color: Colors.black),
          labelMedium: TextStyle(color: Colors.black),
          labelSmall: TextStyle(color: Colors.black)));

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 23),
    primaryColor: const Color.fromARGB(255, 108, 179, 122),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 108, 179, 122),
      foregroundColor: Color.fromARGB(255, 23, 23, 23),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 108, 179, 122),
      foregroundColor: Color.fromARGB(255, 23, 23, 23),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 23, 23, 23),
        iconColor: Colors.white,
        iconSize: 24,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6CB37A),
      secondary: Color.fromARGB(255, 0, 119, 255),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      surface: Color.fromARGB(255, 23, 23, 23),
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white)),
  );

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 23, 23, 23)
          : const Color.fromARGB(255, 234, 230, 230);

  static Color hourLineColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white24
          : Colors.black26;

  static Color timeTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black87;

  static ButtonStyle primaryButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      side: BorderSide.none,
      elevation: 2,
      shadowColor: theme.shadowColor.withAlpha(100),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
    );
  }

  static Color bottomNavButton(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white54
          : Colors.black87.withAlpha(200);

  static Color red = Color.fromARGB(255, 235, 87, 87);
  static Color purple = Color.fromARGB(255, 155, 81, 224);
  static Color blue = Color.fromARGB(255, 47, 129, 237);
  static Color lighterGreen = Color.fromARGB(255, 126, 218, 144);

  static BoxDecoration homeContainerDecoration(BuildContext context) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? const [
                  Color(0xFF1a1a1a),
                  Color(0xFF121212),
                ]
              : const [
                  Color(0xFFfafafa),
                  Color(0xFFf5f5f5),
                ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(120),
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(20),
            blurRadius: 15,
            offset: const Offset(0, -3),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.primary
              : AppTheme.lighterGreen,
          width: 1.5,
        ),
      );
}
