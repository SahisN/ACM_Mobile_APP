import 'package:acm_app/dependency_injection.dart';
import 'package:acm_app/firebase_options.dart';
import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:acm_app/services/notification_services.dart';
import 'package:acm_app/model/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:acm_app/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await UserPreferences.init();
  await NotificationServices.initializeNotification();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Database.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => StateProvider(),
      child: const MyApp(),
    ),
  );
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
