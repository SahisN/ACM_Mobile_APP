import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  shadowColor: Colors.grey.shade500,
  primaryColor: Colors.black,
  focusColor: Colors.black,
  secondaryHeaderColor: Colors.black54,

  // color scheme for light mode
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    inversePrimary: Colors.black,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade200,

    // onPrimary
    onPrimary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  focusColor: Colors.white,
  secondaryHeaderColor: Colors.white54,

  // color scheme for dark mode
  colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade600,
      inversePrimary: Colors.white70, //white70

      // onPrimary & onSecondary
      onPrimary: Colors.white),
);
