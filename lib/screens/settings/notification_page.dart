import 'package:acm_app/provider/state_provider.dart';
import 'package:acm_app/widget/title_check_box.dart';
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
  @override
  Widget build(BuildContext context) {
    bool notificationState =
        Provider.of<StateProvider>(context).notificationState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                onChanged: (bool allowNotification) {
                  setState(() {
                    notificationState = allowNotification;
                  });
                  // Code that will control what will the theme
                  Provider.of<StateProvider>(context, listen: false)
                      .toggleNofication();
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
                    initialValue: 0,
                    onChanged: (int newDay) {},
                  ),
                  const SizedBox(width: 75),

                  // hours wheel
                  NotificationWheelPicker(
                    range: 12,
                    initialValue: 0,
                    onChanged: (int newHour) {},
                  ),
                  const SizedBox(
                    width: 80,
                  ),

                  // minutes wheel
                  NotificationWheelPicker(
                    range: 60,
                    initialValue: 0,
                    onChanged: (int newMinute) {},
                  ),
                ],
              ),
              TitleCheckBox(
                isCheckedIcon: Icons.check,
                isUncheckedIcon: Icons.close,
                isChecked: (bool? selected) {},
                title: 'Favorites Only',
              )
            ],
          ),
        ),
      ),
    );
  }
}
