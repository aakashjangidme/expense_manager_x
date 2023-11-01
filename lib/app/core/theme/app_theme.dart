import 'package:expense_manager_x/app/core/theme/expense_manager_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme(
  BuildContext context,
  ColorScheme colorScheme,
  String fontPreference,
  TextTheme textTheme,
  Color dividerColor,
  SystemUiOverlayStyle systemUiOverlayStyle,
) {
  return ThemeData.from(colorScheme: colorScheme).copyWith(
    textTheme: textTheme,
    colorScheme: colorScheme,
    dialogTheme: dialogTheme,
    timePickerTheme: timePickerTheme,
    appBarTheme: appBarTheme(systemUiOverlayStyle),
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    dialogBackgroundColor: colorScheme.background,
    navigationBarTheme: navigationBarThemeData(
      colorScheme,
      textTheme,
    ),
    navigationDrawerTheme: navigationDrawerThemeData(
      colorScheme,
      textTheme,
    ),
    drawerTheme: drawerThemeData(
      colorScheme,
      textTheme,
    ),
    applyElevationOverlayColor: true,
    inputDecorationTheme: inputDecorationTheme(textTheme),
    elevatedButtonTheme: elevatedButtonTheme(
      context,
      colorScheme,
    ),
    extensions: [lightCustomColor],
    dividerTheme: DividerThemeData(color: dividerColor),
  );
}
