import 'package:eventcountdown/screens/new_event_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EventCountDown());
}

class EventCountDown extends StatelessWidget {
  const EventCountDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NewEventScreen(),
    );
  }
}
