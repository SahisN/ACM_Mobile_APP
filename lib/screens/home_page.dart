import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        ),
      ),
    );
  }
}
