import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TitleCheckBox extends StatelessWidget {
  final IconData isCheckedIcon;
  final IconData isUncheckedIcon;
  final Function(bool? selected) isChecked;
  final String title;
  final bool checked;

  const TitleCheckBox({
    super.key,
    required this.isCheckedIcon,
    required this.isUncheckedIcon,
    required this.isChecked,
    required this.title,
    required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        trailing: RoundCheckBox(
          onTap: isChecked,
          animationDuration: const Duration(milliseconds: 500),
          isChecked: checked,
          checkedWidget: Icon(isCheckedIcon),
          uncheckedWidget: Icon(isUncheckedIcon),
          size: 35,
          //borderColor: Colors.grey.shade200,
          isRound: true,
          checkedColor: Theme.of(context).colorScheme.surface,
          uncheckedColor: Theme.of(context).colorScheme.surface,
          borderColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
