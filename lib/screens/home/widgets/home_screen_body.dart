import 'package:eventcountdown/constants/app_colors.dart';
import 'package:eventcountdown/screens/home/widgets/custom_app_bar.dart';
import 'package:eventcountdown/screens/home/widgets/upcoming_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 30,
                children: [
                  CustomAppBar(),
                  Container(
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.darkColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: Offset.zero,
                          spreadRadius: 5,
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          'Event Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        TimerCountdown(
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          endTime: DateTime.now().add(
                            Duration(
                              days: 1,
                              hours: 5,
                              minutes: 32,
                              seconds: 59,
                            ),
                          ),
                          timeTextStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          colonsTextStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          descriptionTextStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          onEnd: () {},
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          UpComingEventList(),
        ],
      ),
    );
  }
}
