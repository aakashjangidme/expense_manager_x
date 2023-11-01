import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/router/router_config.dart';
import 'core/theme/app_theme.dart';

class ExpenseManagerApp extends ConsumerWidget {
  const ExpenseManagerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String fontPreference = 'Outfit';

    final TextTheme darkTextTheme = GoogleFonts.getTextTheme(
      fontPreference,
      ThemeData.dark().textTheme,
    );
    final TextTheme lightTextTheme = GoogleFonts.getTextTheme(
      fontPreference,
      ThemeData.light().textTheme,
    );

    const int color = 0xFF795548;

    const Color primaryColor = Color(color);

    bool isDynamic = true;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null && isDynamic) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp.router(
          routerConfig: ref.read(goRouterProvider),
          title: 'Expense Manager',
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          theme: appTheme(
            context,
            lightColorScheme,
            fontPreference,
            lightTextTheme,
            ThemeData.light().dividerColor,
            SystemUiOverlayStyle.dark,
          ),
          darkTheme: appTheme(
            context,
            darkColorScheme,
            fontPreference,
            darkTextTheme,
            ThemeData.dark().dividerColor,
            SystemUiOverlayStyle.light,
          ),
        );
      },
    );
  }
}
