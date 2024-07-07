import 'package:acm_app/dependency_injection.dart';
import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/screens/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:acm_app/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await UserPreferences.init();
  // await Awesomenotification().initalize()
  await AwesomeNotifications().initialize(
    null,
    [
      // source : https://www.youtube.com/watch?v=MTGAFvF1qVI, author: Hussain Mustafa
      NotificationChannel(
        channelGroupKey: 'event_channel',
        channelKey: 'event_reminder',
        channelName: 'Event Reminder',
        channelDescription: 'Test notifcation channel',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'event_channel', channelGroupName: 'event_group')
    ],
  );
  bool isAllowedSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowedSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

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
