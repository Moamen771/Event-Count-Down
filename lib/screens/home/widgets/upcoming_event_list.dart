import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/screens/home/widgets/upcoming_event_list_item.dart';
import 'package:flutter/material.dart';
import '../../../services/sql_helper.dart';

class UpComingEventList extends StatelessWidget {
  const UpComingEventList({
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
      return eventDateTime.isAfter(now) &&
          eventDateTime.isBefore(now.add(const Duration(days: 10)));
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
