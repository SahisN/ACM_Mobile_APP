// https://pub.dev/packages/google_nav_bar
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomGNav extends StatelessWidget {
  const BottomGNav({super.key, required this.selectedIndex});

  // control which icon is selected on bottom tab navigator
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GNav(
      //rippleColor: Colors.blue,
      //hoverColor: Colors.blueAccent,
      selectedIndex: selectedIndex,

      // Tabs take GButton which are bottom tabnavigator botton
      // Each botton redirects to respective page shown in their icon
      tabs: [
        GButton(
          icon: Icons.calendar_month_sharp,
          //iconColor: Colors.white,
          onPressed: () {},
        ),
        GButton(
          icon: Icons.contacts_sharp,
          //iconColor: Colors.white,
          onPressed: () {},
        ),
        GButton(
          icon: Icons.settings,
          //iconColor: Colors.white,
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.blue,
      activeColor: Colors.white,
      curve: Curves.linear,
      iconSize: 29,
      // changes so the icon buttons have no animation when selected
      duration: const Duration(seconds: 0),
    );
  }
}
