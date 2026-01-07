import "package:flutter/material.dart";
import "package:think_bot/Resources/resources.dart";

class AppThemes {
  final lightTheme = ThemeData(brightness: Brightness.light);
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: R.colors.blackColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: R.colors.whiteColor,
      selectionColor: R.colors.pinPutFillColor,
      selectionHandleColor: R.colors.whiteColor,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: R.colors.transparent,
      surfaceTintColor: R.colors.transparent,
      titleTextStyle: R.textStyle.mediumRobotoDisplay(),
    ),
  );
}
