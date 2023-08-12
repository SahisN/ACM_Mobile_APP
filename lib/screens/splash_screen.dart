import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:acm_app/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AnimatedSplashScreen(
          splash: Column(
            children: [
              Image.asset(
                'assets/images/acm_logo.png',
                width: 300,
                height: 250,
              ),
            ],
          ),
          nextScreen: const HomePage(),
          splashIconSize: 250,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: const Color.fromARGB(255, 4, 112, 244),
          animationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}

/**
 * Padding(
                  padding: const EdgeInsets.all(50),
                  child: AnimatedScale(
                    scale: scale,
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      'assets/images/flyers.png',
                      width: 100,
                      height: 300,
                    ),
                  ),
                ),
 */