// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

/** 
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 72, 171),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 1, 18, 23),
);
*/

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 6, 72, 171),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: theme,
      home: const HomePage(),
    ),
  );
}
