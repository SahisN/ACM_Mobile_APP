import 'package:acm_app/api/firebase_api.dart';
import 'package:acm_app/dependency_injection.dart';
import 'package:acm_app/firebase_options.dart';
import 'package:acm_app/provider/theme_provider.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:acm_app/screens/notification_page.dart';
import 'package:acm_app/widget/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

//import 'package:google_fonts/google_fonts.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
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
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
