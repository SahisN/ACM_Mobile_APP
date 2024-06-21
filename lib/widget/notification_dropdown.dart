import 'package:flutter/material.dart';

class NotificationDropdown extends StatefulWidget {
  final String label;
  final List<String> option;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NotificationDropdown({
    super.key,
    required this.label,
    required this.option,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NotificationDropdown> createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.option.first;

    return DropdownButton<String>(
      items: widget.option.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value), // Corrected Text widget usage
          );
        },
      ).toList(),

      // default dropdown value
      value: dropdownValue,

      // on change handler
      onChanged: (String? newValue) {
        if (newValue != null && newValue != dropdownValue) {
          setState(() {
            dropdownValue = newValue;
          });
        }
      },
    );
  }
}
