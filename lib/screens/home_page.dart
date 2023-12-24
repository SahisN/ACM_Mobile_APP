import 'package:acm_app/screens/calender_page.dart';
import 'package:acm_app/screens/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _selectedIndex is used to select apporiate screen from _screen List
  int _selectedIndex = 0;

  // _screens stores all the list of screens
  static List<Widget> _screens = <Widget>[
    CalendarPage(),
    ContactPage(),
    Text('Settings')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        // stores tab_icon, name of the icon
        tabs: const [
          GButton(
            icon: Icons.calendar_month_sharp,
          ),
          GButton(
            icon: Icons.contacts_sharp,
          ),
          GButton(
            icon: Icons.settings,
          )
        ],
        iconSize: 29,
        // duration seconds = 0 to cancel any animation
        duration: const Duration(seconds: 0),

        // highlights the selected tab and unselected tabs
        selectedIndex: _selectedIndex,
        color: Colors.black,
        activeColor: Colors.blueAccent,

        // this function is invoked whenever user clicks a tab
        // recieves the tab index and updates _selectedIndex
        onTabChange: (index) {
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
