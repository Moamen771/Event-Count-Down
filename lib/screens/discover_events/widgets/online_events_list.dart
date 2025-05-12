import 'package:eventcountdown/models/online_events.dart';
import 'package:eventcountdown/screens/discover_events/widgets/online_events_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineEventsList extends StatelessWidget {
  const OnlineEventsList({super.key, required this.onlineEvents});

  final List<OnlineEvent> onlineEvents;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList.builder(
        itemCount: onlineEvents.length,
        itemBuilder: (context, index) =>
            OnlineEventsListItem(onlineEvent: onlineEvents[index]),
      ),
    );
  }
}
