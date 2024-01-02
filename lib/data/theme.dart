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
    background: Colors.grey.shade200,
    inversePrimary: Colors.black,
    primary: Colors.white,
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
      background: Colors.grey.shade900,
      primary: Colors.black,
      secondary: Colors.grey.shade600,
      inversePrimary: Colors.white70,

      // onPrimary & onSecondary
      onPrimary: Colors.white),
);
