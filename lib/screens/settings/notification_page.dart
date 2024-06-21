import 'package:acm_app/widget/settings_tile.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Allow Notification',
                onTap: () {},
              ),

              const SizedBox(
                height: 20,
              ),

              // early reminder customization
              Text(
                'Early Reminder Customization',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
