import 'package:acm_app/provider/theme_provider.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpond;
import 'package:provider/provider.dart' as provider;
import 'package:riverpod/riverpod.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    riverpond.ProviderScope(
      child: provider.ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    final themeProvider = provider.Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: themeProvider.themeData,
    );
  }
}
