import 'package:acm_app/screens/calendar_page.dart';
import 'package:acm_app/screens/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acm_app/screens/settings_page.dart';
import 'package:acm_app/screens/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void _getMessage() async {
  // getting data from firestore
  final userData = await FirebaseFirestore.instance
      .collection('semesterEvents')
      .doc('W9jFmK5aakGLKv1t7jhq')
      .get();

  // printing in
  print(userData['altText']);
}

class _HomePageState extends State<HomePage> {
  // _selectedIndex is used to select apporiate screen from _screen List
  int _selectedIndex = 0;

  // _screens stores all the list of screens
  static const List<Widget> _screens = <Widget>[
    CalendarPage(),
    FavoritePage(),
    ContactPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        // stores tab_icon, name of the icon
        tabs: [
          const GButton(
            icon: Icons.calendar_month_sharp,
          ),
          GButton(
            icon: _selectedIndex == 1 ? Icons.favorite : Icons.heart_broken,
          ),
          const GButton(
            icon: Icons.contacts_sharp,
          ),
          const GButton(
            icon: Icons.settings,
          )
        ],
        iconSize: 29,
        // duration seconds = 0 to cancel any animation
        duration: const Duration(seconds: 0),

        // highlights the selected tab and unselected tabs
        selectedIndex: _selectedIndex,

        // inactive tab icon color
        color: Theme.of(context).secondaryHeaderColor,

        // active tab icon color
        activeColor: _selectedIndex == 1
            ? Colors.red
            : Theme.of(context).focusColor, //  theme.of(context).focusColor
        // tab color
        backgroundColor: Theme.of(context).colorScheme.primary,

        // this function is invoked whenever user clicks a tab
        // recieves the tab index and updates _selectedIndex
        onTabChange: (index) {
          _getMessage();
          // used to update _selectedIndex and restart Widget Build()
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      // Uses _screens and _selectedIndex to display apporiate screen (depending on selected tab)
      body: _screens[_selectedIndex],
    );
  }
}
