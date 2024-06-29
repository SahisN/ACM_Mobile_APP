// theme
import 'package:acm_app/provider/state_provider.dart';
// pages
import 'package:acm_app/screens/settings/about_page.dart';
import 'package:acm_app/screens/settings/contact_page.dart';
import 'package:acm_app/screens/settings/feedback_page.dart';
import 'package:acm_app/screens/settings/notification_page.dart';
// widgets
import 'package:acm_app/widget/settings_switch.dart';
import 'package:acm_app/widget/settings_tile.dart';
//essential
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<StateProvider>(context).darkModeSelected;
    //bool notification = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 240,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  // General settings
                  Text(
                    'General',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),

                  const SizedBox(height: 10),

                  SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notification',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                  ),

                  SettingsSwitch(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    size: 18,
                    value: darkMode,
                    active: Colors.white,
                    inactive: Colors.black,
                    onChanged: (bool darkModeSelected) {
                      setState(() {
                        darkMode = darkModeSelected;
                      });
                      // Code that will control what will the theme
                      Provider.of<StateProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),

                  SettingsTile(
                    icon: Icons.help_outline,
                    title: 'About Us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // dividing space using sizebox
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 190,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Feedback
                  Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SettingsTile(
                    icon: Icons.contacts_outlined,
                    title: 'Contact US',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactPage(),
                        ),
                      );
                    },
                  ),

                  SettingsTile(
                    icon: Icons.send_outlined,
                    title: 'Send Feedback',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
