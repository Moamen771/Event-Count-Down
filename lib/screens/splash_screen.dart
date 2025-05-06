import 'package:eventcountdown/screens/new_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(
    //   Duration(milliseconds: 2500),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NewEventScreen(),
    //     ),
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //ToDo: Logo animation
          Center(
            child: Image.asset(
              'assets/images/splash/splash_even.png',
            ).animate().slideY(
                  begin: 5,
                  duration: const Duration(seconds: 2),
                  curve: Curves.elasticInOut,
                ),
          ),
          Center(
            child: Image.asset(
              'assets/images/splash/splash_t.png',
            ).animate().slideY(
                  begin: -5,
                  duration: const Duration(seconds: 2),
                  curve: Curves.elasticInOut,
                ),
          ),
        ],
      ),
    );
  }
}
