import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CustomTimerCountdown extends StatelessWidget {
  final String title;
  final DateTime targetDate;
  final VoidCallback? onEnd;

  const CustomTimerCountdown({
    super.key,
    required this.title,
    required this.targetDate,
    this.onEnd,
  });

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invalid date, event has passed!"),
        backgroundColor: AppColors.darkColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPast = targetDate.isBefore(DateTime.now());

    if (isPast) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackBar(context);
      });
    }

    return Container(
      padding: const EdgeInsets.all(15),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.darkerColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          TimerCountdown(
            format: CountDownTimerFormat.daysHoursMinutesSeconds,
            endTime: isPast ? DateTime.now() : targetDate,
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
            onEnd: isPast ? () {} : (onEnd ?? () {}),
          ),
        ],
      ),
    );
  }
}
