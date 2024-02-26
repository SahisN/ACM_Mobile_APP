import 'package:acm_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notification = false;
  String selectedNotificationOption = 'Option 1'; // Default selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(2),
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
                            ),
                          ),
                        ),
                        Switch(
                          value: darkMode,
                          onChanged: (darkModeSelected) {
                            setState(() {
                              darkMode = darkModeSelected;
                            });
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                },
                              ),
                            ],
                          ),
                          if (notification)
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                              child: DropdownButton<String>(
                                value: selectedNotificationOption,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedNotificationOption = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Option 1',
                                  'Option 2',
                                  'Option 3'
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                        ],
                      ),
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
