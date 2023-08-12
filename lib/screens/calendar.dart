import 'package:acm_app/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime now = DateTime.now();
  final firstDate =
      DateTime.utc(2023, 7, 31); //DateTime(now.year - 1, now.month);
  final lastDay =
      DateTime.utc(2025, 7, 31); //DateTime(now.year + 5, now.month);

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      now = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            locale: "en_US",
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, now),
            focusedDay: now,
            firstDay: firstDate,
            lastDay: lastDay,
            onDaySelected: _onDaySelected,
          ),
          const SizedBox(height: 15),
          const Text(
            'Events',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          now.day == 24
              ? const EventItem()
              : const Text(
                  'No Events Avaliable',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
        ],
      ),
    );
  }
}
