import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the entire content
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            Table(
              columnWidths: {
                0: FlexColumnWidth(0.5), // Column width for the Switch
                1: FlexColumnWidth(2),   // Column width for the Text
              },
              children: [
                TableRow(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Dark Theme',
                            style: TextStyle(fontSize: 32.0), // Font size of the Text
                          ),
                        ),
                        Switch(
                          value: _switchValue1,
                          onChanged: (value) {
                            setState(() {
                              _switchValue1 = value;
                            });
                            // Code that will control what will happen when switch is turn on/off
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
                        const Expanded(
                          child: Text(
                            'Notifications',
                            style: TextStyle(fontSize: 32.0),
                          ),
                        ),
                        Switch(
                          value: _switchValue2,
                          onChanged: (value) {
                            setState(() {
                              _switchValue2 = value;
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
