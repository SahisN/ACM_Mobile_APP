import 'package:acm_app/provider/theme_provider.dart';
import 'package:acm_app/widget/settings_tile.dart';
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
    //bool darkMode = Provider.of<ThemeProvider>(context).darkModeSelected;
    //bool notification = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),

            // General settings
            const Text(
              'General',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notification',
              onTap: () {
                // Handle tap
              },
            ),

            SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              onTap: () {
                // Handle tap
              },
            ),

            SettingsTile(
              icon: Icons.help_outline,
              title: 'About Us',
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
