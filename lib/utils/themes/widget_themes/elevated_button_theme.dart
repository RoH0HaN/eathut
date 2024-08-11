import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

/* -- Light & Dark Elevated Button Themes --*/

class AppElevatedButtonThemes {
  AppElevatedButtonThemes._(); //To Avoid Creating Instance

  /* -- Light Elevated Button Themes --*/
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      foregroundColor: white,
      backgroundColor: baseColor,
      side: const BorderSide(color: baseColor),
      // padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );
}
