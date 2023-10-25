import 'package:flutter/material.dart';
import 'package:acm_app/widgets/bottom_g_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomGNav(
          selectedIndex: 0,
        ),
      ),
    );
  }
}
