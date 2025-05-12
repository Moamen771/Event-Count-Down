import 'package:eventcountdown/screens/home/widgets/home_screen_body.dart';
import 'package:eventcountdown/screens/new_event/new_event_screen.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(
          const NewEventScreen(),
          transition: Transition.fadeIn,
        ),
        backgroundColor: AppColors.lightColor,
        child: const Icon(
          Icons.add,
          color: AppColors.darkerColor,
        ),
      ),
    );
  }
}
