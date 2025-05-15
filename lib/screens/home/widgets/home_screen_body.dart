import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/screens/home/widgets/custom_app_bar.dart';
import 'package:eventcountdown/screens/home/widgets/upcoming_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../services/sql_helper.dart';
import '../../../utils/app_colors.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final sqlHelper = SqlHelper();
  final eventsList = <Event>[].obs;

  @override
  void initState() {
    super.initState();
    refreshEvents();
  }

  Future<void> refreshEvents() async {
    eventsList.value = await sqlHelper.getEvents();
  }

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
                children: [
                  const CustomAppBar(title: 'Event Countdown'),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 32),
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
                      children: [
                        Obx(
                          () {
                            final now = DateTime.now();

                            final upcomingEvents = eventsList.where((event) {
                              final eventDateTime =
                                  DateTime.parse('${event.date} ${event.time}');
                              return eventDateTime.isAfter(now) &&
                                  eventDateTime.isBefore(
                                      now.add(const Duration(days: 10)));
                            }).toList()
                              ..sort((a, b) {
                                final aDateTime =
                                    DateTime.parse('${a.date} ${a.time}');
                                final bDateTime =
                                    DateTime.parse('${b.date} ${b.time}');
                                return aDateTime.compareTo(bDateTime);
                              });

                            final nextEvent = upcomingEvents.isNotEmpty
                                ? upcomingEvents.first
                                : null;

                            final endTime = nextEvent != null
                                ? DateTime.parse(
                                    '${nextEvent.date} ${nextEvent.time}')
                                : DateTime.now();

                            final timerKey = ValueKey(nextEvent?.id ?? 'empty');

                            return Column(
                              children: [
                                Text(
                                  nextEvent?.title ?? 'No Event',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.darkerColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                KeyedSubtree(
                                  key: timerKey,
                                  child: TimerCountdown(
                                    format: CountDownTimerFormat
                                        .daysHoursMinutesSeconds,
                                    endTime: endTime,
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
                                    onEnd: () async {
                                      if (nextEvent != null) {
                                        await sqlHelper
                                            .deleteEvent(nextEvent.id!);
                                        await refreshEvents();

                                        // if (context.mounted) {
                                        // }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      color: AppColors.darkerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => eventsList.isEmpty
                ? SliverFillRemaining(
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
                  )
                : UpComingEventList(
                    events: eventsList,
                    refreshCallback: refreshEvents,
                  ),
          ),
        ],
      ),
    );
  }
}
