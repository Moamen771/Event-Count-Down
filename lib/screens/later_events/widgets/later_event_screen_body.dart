import 'dart:async';

import 'package:eventcountdown/screens/later_events/widgets/upcoming_later_event_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/event.dart';
import '../../../services/sql_helper.dart';
import '../../../utils/app_colors.dart';
import '../../home/widgets/custom_app_bar.dart';

class LaterEventScreenBody extends StatefulWidget {
  const LaterEventScreenBody({super.key});

  @override
  State<LaterEventScreenBody> createState() => _LaterEventScreenBodyState();
}

class _LaterEventScreenBodyState extends State<LaterEventScreenBody> {
  final sqlHelper = SqlHelper();
  final RxList<Event> laterEventsList = <Event>[].obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    refreshEvents();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      refreshEvents();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> refreshEvents() async {
    final allEvents = await sqlHelper.getEvents();
    final now = DateTime.now();

    laterEventsList.value = allEvents.where((event) {
      final eventDateTime = DateTime.parse('${event.date} ${event.time}');
      return eventDateTime.isAfter(now.add(const Duration(days: 10)));
    }).toList()
      ..sort((a, b) {
        final aDateTime = DateTime.parse('${a.date} ${a.time}');
        final bDateTime = DateTime.parse('${b.date} ${b.time}');
        return aDateTime.compareTo(bDateTime);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppBar(title: 'Later Events'),
            ),
            Obx(() {
              return laterEventsList.isEmpty
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
                  : UpComingLaterEventList(
                      events: laterEventsList,
                      refreshCallback: refreshEvents,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
