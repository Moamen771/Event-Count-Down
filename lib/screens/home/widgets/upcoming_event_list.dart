import 'package:eventcountdown/screens/home/widgets/upcoming_event_list_item.dart';
import 'package:flutter/material.dart';

class UpComingEventList extends StatelessWidget {
  const UpComingEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: UpComingEventListItem(
          title: 'title',
          year: 2025,
          month: 6,
          day: 8,
          hour: 12,
          minute: 0,
        ),
      ),
    );
  }
}
