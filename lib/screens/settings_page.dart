import 'package:acm_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkModeSelected;
    bool notification = false;

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Padding around the entire content
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5), // Column width for the Switch
                1: FlexColumnWidth(2), // Column width for the Text
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
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ), // Font size of the Text
                          ),
                        ),
                        Switch(
                          value: darkMode,
                          onChanged: (value) {
                            setState(() {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                              darkMode = value;
                            });
                            // Code that will control what will the theme
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
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                        Switch(
                          value: notification,
                          onChanged: (value) {
                            setState(() {
                              notification = value;
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
      ),
    );
  }
}
