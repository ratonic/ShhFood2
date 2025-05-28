import 'package:flutter/material.dart';

class AppConfig {
  static final theme = ThemeData(
    primaryColor: const Color(0xFF4B0082),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4B0082),
      secondary: const Color(0xFF40E0D0),
    ),
  );

  static const String appName = 'Shh Food';
}