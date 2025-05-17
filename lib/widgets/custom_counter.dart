import 'package:eventcountdown/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../utils/app_colors.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.lightColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text(
            event.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.darkerColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          TimerCountdown(
            format: CountDownTimerFormat.daysHoursMinutesSeconds,
            endTime: DateTime.now().add(
              const Duration(
                days: 1,
                hours: 5,
                minutes: 32,
                seconds: 59,
              ),
            ),
            timeTextStyle: const TextStyle(
              color: AppColors.darkColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            colonsTextStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.darkerColor,
            ),
            descriptionTextStyle: const TextStyle(
              color: AppColors.darkerColor,
              fontSize: 16,
            ),
            onEnd: () {},
          ),
        ],
      ),
    );
  }
}
