import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),

  // color scheme for light mode
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade400,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade200),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),

  // color scheme for dark mode
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);
