import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class NotificationWheelPicker extends StatefulWidget {
  final int range;
  final int initialValue;
  final Function(int index) onChanged;

  const NotificationWheelPicker({
    super.key,
    required this.range,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NotificationWheelPicker> createState() =>
      _NotificationWheelPickerState();
}

class _NotificationWheelPickerState extends State<NotificationWheelPicker> {
  final now = TimeOfDay.now();

  late final wheel = WheelPickerController(
    itemCount: widget.range,
    initialIndex: widget.initialValue,
  );

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 26.0,
      height: 1.5,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    final wheelStyle = WheelPickerStyle(
      size: 200,
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget itemBuilder(BuildContext context, int index) {
      return Text(
        "$index".padLeft(
          2,
        ),
        style: textStyle,
        selectionColor: Theme.of(context).colorScheme.inversePrimary,
      );
    }

    return WheelPicker(
      builder: itemBuilder,
      controller: wheel,
      style: wheelStyle,
      enableTap: true,
      onIndexChanged: widget.onChanged,
      selectedIndexColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }

  @override
  void dispose() {
    wheel.dispose();
    super.dispose();
  }
}
