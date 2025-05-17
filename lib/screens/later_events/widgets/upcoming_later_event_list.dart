import 'package:flutter/material.dart';

import '../../../models/event.dart';
import '../../../services/sql_helper.dart';
import '../../home/widgets/upcoming_event_list_item.dart';

class UpComingLaterEventList extends StatelessWidget {
  const UpComingLaterEventList({
    super.key,
    required this.events,
    required this.refreshCallback,
  });

  final List<Event> events;
  final Future<void> Function() refreshCallback;

  @override
  Widget build(BuildContext context) {
    final sqlHelper = SqlHelper();

    final now = DateTime.now();
    final filteredEvents = events.where((event) {
      final eventDateTime = DateTime.parse('${event.date} ${event.time}');
      return eventDateTime.isAfter(now.add(const Duration(days: 10)));
    }).toList()
      ..sort((a, b) {
        final aDateTime = DateTime.parse('${a.date} ${a.time}');
        final bDateTime = DateTime.parse('${b.date} ${b.time}');
        return aDateTime.compareTo(bDateTime);
      });

    return SliverList.builder(
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await sqlHelper.deleteEvent(filteredEvents[index].id!);
            await refreshCallback();
          },
          child: UpComingEventListItem(
            event: filteredEvents[index],
          ),
        ),
      ),
    );
  }
}
