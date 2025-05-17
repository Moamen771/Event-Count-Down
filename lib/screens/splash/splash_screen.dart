import 'package:eventcountdown/screens/nav_bar_screen/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
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

  void navigateToHome() {
    Future.delayed(
      const Duration(
        milliseconds: 2600,
      ),
      () {
        Get.off(
          const NavBarScreen(),
          transition: Transition.fadeIn,
        );
      },
    );
  }
}
