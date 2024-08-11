import 'package:flutter/material.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: AppElevatedButtonThemes.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlinedButtonThemes.lightOutlinedButtonTheme,
    scaffoldBackgroundColor: Colors.white,
  );
}
