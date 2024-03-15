import 'package:acm_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notification = false;
  Duration selectedDuration = Duration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100.0),
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
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
                        if (isEnabled) {
                          _showDateTimePicker(context);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final Duration? picked = await showCupertinoModalPopup<Duration>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 3000,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hms,
            initialTimerDuration: selectedDuration,
            onTimerDurationChanged: (Duration duration) {
              setState(() {
                selectedDuration = duration;
              });
            },
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDuration = picked;
      });
      // Add code here to execute when a new duration is selected
      print('Selected duration: $picked');
    }
  }
}
