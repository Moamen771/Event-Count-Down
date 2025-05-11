import 'package:eventcountdown/screens/splash/splash_screen.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventCountDown extends StatelessWidget {
  const EventCountDown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.lighterColor,
      ),
      home: SplashScreen(),
    );
  }
}
