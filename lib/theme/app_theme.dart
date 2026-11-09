import 'package:flutter/material.dart';

const int lightRed = 0xFFBE0F14;
const int darkRed = 0xFFB71C1C;
const int secondaryLightRed = 0xFF83070A;
const int secondaryDarkRed = 0xFF7F1618;
const int darkContainer = 0xFF1A1A1C;
const int surfaceBlack = 0xFF0F0F11;

ThemeData lightTheme = ThemeData(
  //Navigation bar theme
  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: Colors.grey,
    height: 75,
    backgroundColor: Colors.white,
    indicatorColor: Color(lightRed).withValues(alpha: 0.1),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: Color(lightRed), size: 30);
      }
      return const IconThemeData(color: Colors.black, size: 30);
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Color(lightRed).withValues(alpha: 0.08);
      }
      return null;
    }),
  ),

  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: 'Alexandria',
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.9,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Color(lightRed),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
    ),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Color(lightRed),
    secondary: Colors.black,
    tertiary: Color(secondaryLightRed),
    outline: Colors.grey.shade300,
    primaryContainer: Colors.grey.shade200,
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) =>
        const Icon(Icons.arrow_back_ios_new, color: Colors.white),
  ),
);

ThemeData darkTheme = ThemeData(
  //Navigation bar theme
  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: Colors.grey,
    height: 75,
    backgroundColor: Colors.black,
    indicatorColor: Color(darkRed).withValues(alpha: 0.15),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: Color(darkRed), size: 30);
      }
      return const IconThemeData(color: Colors.white, size: 30);
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Color(darkRed).withValues(alpha: 0.08);
      }
      return null;
    }),
  ),

  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Alexandria',
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.9,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Color(darkRed),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),

  colorScheme: ColorScheme.dark(
    surface: Color(surfaceBlack),
    primary: Color(darkRed),
    secondary: Colors.white,
    tertiary: Color(secondaryDarkRed),
    primaryContainer: Color(darkContainer),
    outline: Colors.white.withValues(alpha: 0.07),
  ),

  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) =>
    const Icon(Icons.arrow_back_ios_new),
  ),
);
