import 'package:eventcountdown/database/sql_helper.dart';
import 'package:eventcountdown/screens/home/widgets/custom_app_bar.dart';
import 'package:eventcountdown/screens/home/widgets/upcoming_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final sqlHelper = SqlHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sqlHelper.getEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: AppColors.darkColor,
              size: 50,
            ),
          );
        } else if (snapshot.hasData && (snapshot.data?.isEmpty ?? true)) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 30,
                      children: [
                        const CustomAppBar(),
                        Container(
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
                            spacing: 10,
                            children: [
                              const Text(
                                'No Event',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.darkerColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              TimerCountdown(
                                format: CountDownTimerFormat
                                    .daysHoursMinutesSeconds,
                                endTime: DateTime.now().add(
                                  const Duration(
                                    days: 0,
                                    hours: 0,
                                    minutes: 0,
                                    seconds: 0,
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
                        ),
                        const Text(
                          'Upcoming Events',
                          style: TextStyle(
                            color: AppColors.darkColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Center(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.darkColor,
                      highlightColor: AppColors.lightColor,
                      child: const Text(
                        'No Events Added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 30,
                      children: [
                        const CustomAppBar(),
                        Container(
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
                              const Text(
                                'Event Name',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.darkerColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              TimerCountdown(
                                format: CountDownTimerFormat
                                    .daysHoursMinutesSeconds,
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
                        ),
                        const Text(
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
                UpComingEventList(
                  events: snapshot.data,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
