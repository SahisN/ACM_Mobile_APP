

import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function(bool value) onChanged;
  final bool value;

  const SettingsSwitch({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontSize: 18),),
        trailing: Switch(value: value, onChanged: onChanged,),
      ),
    );
  }
}