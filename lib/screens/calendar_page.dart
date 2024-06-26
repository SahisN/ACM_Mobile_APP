import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/widget/event_card.dart';

bool isExpanded = false;
List<EventItem> eventList = [
  EventItem(
      'ACM GENERAL MEETING',
      'The first meeting of the semester, in were any student is welcome to join. During this meeting students will meet board members and engage on club activities.',
      DateTime(1, 16, 2024),
      "Salazar Hall 234",
      ""),
  EventItem(
      'ACM GAME NIGHT',
      'Game night is an event that encourages Club members to relax, game and enjoy each others company. We hosted once a semester and we have tournaments where students can win prices.',
      DateTime(1, 1, 1),
      "Salazar Hall 163",
      ""),
  EventItem(
      'ACM MOVIE NIGHT',
      'Movie night is the ACM Hangout where students meet up at the movie theater and enjoy a carefully selected film that will blow your socks off. Please make sure to sing up before tickets run out.',
      DateTime(1, 1, 1),
      "Alhambra ",
      ""),
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
          //backgroundColor: Theme.of(context).colorScheme.background,
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
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 22,
                  ),
                ),
                // affects numbers in calendar ex 1 2 3 4
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 17,
                  ),
                  // affects days of week in calendar ex mon, tuesday, wed
                  weekendTextStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                  ),
                ),
                // affect weekend of week in calendar ex sat, sun
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                  ),
                  weekendStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                  ),
                ),
                calendarBuilders: const CalendarBuilders(
                    //markerBuilder:
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
              Text(
                'Events',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 15),

              //Display Event list if not emtpy, otherwise display "No event" text
              eventList.isEmpty
                  ? const Text(
                      "No Events for today",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
        backgroundColor: Theme.of(context).colorScheme.surface);
  }
}
