import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lighterColor,
      body: Stack(
        children: [
          //ToDo: Logo animation
          Center(
            child: Image.asset(
              'assets/images/splash/splash-logo-even.png',
            ).animate().slideY(
                  begin: 2,
                  duration: const Duration(seconds: 2),
                  curve: Curves.elasticInOut,
                ),
          ),
          Center(
            child: Image.asset(
              'assets/images/splash/splash-logo-t.png',
            ).animate().slideY(
                  begin: -2,
                  duration: const Duration(seconds: 2),
                  curve: Curves.elasticInOut,
                ),
          ),
        ],
      ),
    );
  }
}
