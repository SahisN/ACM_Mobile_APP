import 'package:acm_app/provider/theme_provider.dart';
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
    bool darkMode = Provider.of<ThemeProvider>(context).darkModeSelected;
    bool notification = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5), // Column width for the Switch
              1: FlexColumnWidth(), // Column width for the Text
            },
            children: [
              TableRow(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Dark Theme',
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ), // Font size of the Text
                        ),
                      ),
                      Switch(
                        value: darkMode,
                        onChanged: (darkModeSelected) {
                          setState(() {
                            darkMode = darkModeSelected;
                          });
                          // Code that will control what will the theme
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              TableRow(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      Switch(
                        value: notification,
                        onChanged: (isEnabled) {
                          setState(() {
                            notification = isEnabled;
                          });
                          // Code that will control what will happen when switch is turn on/off
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
