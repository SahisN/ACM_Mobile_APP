import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/user_preferences.dart';
import 'package:acm_app/util/set_reminder.dart';
import 'package:acm_app/widget/notification_wheel_picker.dart';
import 'package:acm_app/widget/settings_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late bool notificationState;
  late List<int> timeState;
  late bool favoriteOnlyState;

  @override
  void dispose() {
    // save all changes here
    // print(notificationState);

    UserPreferences.setTime(timeState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notificationState = Provider.of<StateProvider>(context).notificationState;
    timeState = Provider.of<StateProvider>(context).time;
    favoriteOnlyState = Provider.of<StateProvider>(context).favoriteOnlyState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              // enable/disable notification option
              SettingsSwitch(
                icon: Icons.notifications_outlined,
                title: 'Allow Notification',
                size: 22,
                value: notificationState,
                active: Colors
                    .green, //Theme.of(context).colorScheme.inverseSurface,
                inactive: Theme.of(context).colorScheme.inversePrimary,
                onChanged: (bool allowNotification) {
                  setState(() {
                    notificationState = allowNotification;
                  });
                  // Code that will control what will the theme
                  Provider.of<StateProvider>(context, listen: false)
                      .toggleNofication();

                  enableNotification(notificationState, context);
                },
              ),

              const SizedBox(
                height: 20,
              ),

              // early reminder customization
              Center(
                child: Text(
                  'Set Early Reminders',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Days',
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(width: 60),
                  Text(
                    'Hours',
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(width: 60),
                  Text(
                    'Minutes',
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),
              // time wheel
              Row(
                children: [
                  // days wheel
                  NotificationWheelPicker(
                    range: 5,
                    initialValue: timeState[0],
                    onChanged: (int newDay) {
                      timeState[0] = newDay;
                    },
                  ),
                  const SizedBox(width: 75),

                  // hours wheel
                  NotificationWheelPicker(
                    range: 12,
                    initialValue: timeState[1],
                    onChanged: (int newHour) {
                      timeState[1] = newHour;
                    },
                  ),
                  const SizedBox(
                    width: 80,
                  ),

                  // minutes wheel
                  NotificationWheelPicker(
                    range: 60,
                    initialValue: timeState[2],
                    onChanged: (int newMinute) {
                      timeState[2] = newMinute;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
