import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/screens/home/widgets/upcoming_event_list_item.dart';
import 'package:flutter/material.dart';

class UpComingEventList extends StatelessWidget {
  const UpComingEventList({super.key, required this.events});

  final List<Map> events;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: UpComingEventListItem(
          event: Event(
              events[index]['title'],
              events[index]['desc'],
              events[index]['date'],
              events[index]['time'],
              events[index]['location']),
        ),
      ),
    );
  }
}
