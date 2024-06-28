import 'package:acm_app/dependency_injection.dart';
import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
//import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateProvider(),
      child: const MyApp(),
    ),
  );
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<StateProvider>(context).themeData,
    );
  }
}
