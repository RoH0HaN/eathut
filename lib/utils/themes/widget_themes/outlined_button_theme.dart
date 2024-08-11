import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class AppOutlinedButtonThemes {
  AppOutlinedButtonThemes._(); // To avoid creating an instance

  /* -- Light Outlined Button Themes --*/
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      foregroundColor: baseColor,
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: baseColor),
      // padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );
}
