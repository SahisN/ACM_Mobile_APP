import 'package:acm_app/screens/contact.dart';
import 'package:acm_app/screens/calendar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _contactOnPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return const Contact();
        },
      ),
    );
  }

  void _calendarOnPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return const CalendarScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 112, 244),
                Color.fromARGB(255, 0, 38, 255)
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/acm_logo.png',
                  width: 300,
                ),
                ElevatedButton(
                  onPressed: () {
                    _calendarOnPress(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                        right: 60,
                        left: 60,
                        bottom: 25,
                        top: 25,
                      ),
                      elevation: 3,
                      side: const BorderSide(width: 3, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text(
                    'Calendar',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    _contactOnPress(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                        right: 67,
                        left: 67,
                        bottom: 25,
                        top: 25,
                      ),
                      elevation: 3,
                      side: const BorderSide(width: 3, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
