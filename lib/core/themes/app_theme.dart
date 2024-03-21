import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color(0xff5193DF).withOpacity(0.7);
  static Color lightPrimaryColor = const Color(0xff58FFCC);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color(0xff8ED5CB);
  static Color lightCounterColor = const Color(0xff1E6261);

  static Color darkBackgroundColor = const Color(0xFF0C0E2A);
  static Color darkPrimaryColor = const Color(0xFF6E9FFB);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkParticlesColor = const Color(0xff2E539F);
  static Color darkCounterColor = const Color(0xfff0d43a);

  const AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: lightPrimaryColor,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: lightPrimaryColor,
      secondary: lightAccentColor,
      background: lightBackgroundColor,
      outline: lightCounterColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: darkPrimaryColor,
      secondary: darkAccentColor,
      background: darkBackgroundColor,
      outline: darkCounterColor,
    ),



    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}

extension ThemeExtras on ThemeData {
  Color get particlesColor => brightness == Brightness.light
      ? AppTheme.lightParticlesColor
      : AppTheme.darkParticlesColor;
}
