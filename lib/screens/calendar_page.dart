import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/widget/event_card.dart';

bool isExpanded = false;
List<EventItem> eventList = [
  EventItem('A', 'djfnef', DateTime(1, 1, 1), "somewhere", ""),
  EventItem('B', 'djfnef', DateTime(1, 1, 1), "somewhere", ""),
  EventItem('C', 'djfnef', DateTime(1, 1, 1), "somewhere", ""),
];

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime now = DateTime.now();
  final firstDate =
      DateTime.utc(2023, 7, 31); //DateTime(now.year - 1, now.month);
  final lastDay =
      DateTime.utc(2025, 7, 31); //DateTime(now.year + 5, now.month);

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      now = day;
    });
    //fetch events
    _fetchEvents();
  }

  // ignore: unused_element
  void _onExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _fetchEvents() {
    //calls firebase class to return a list of events
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
              onPressed: _onExpand,
              icon: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down))
        ],
      ),
      body: Center(
        child: Column(
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
              calendarFormat:
                  isExpanded ? CalendarFormat.month : CalendarFormat.twoWeeks,
            ),
            const SizedBox(height: 15),
            const Text(
              'Events',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            //Display Event list if not emtpy, otherwise display "No event" text
            eventList.isEmpty
                ? const Text(
                    "No Events for today",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: eventList.length,
                      shrinkWrap: true,
                      itemBuilder: (_, i) => EventCard(eventList[i]),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}