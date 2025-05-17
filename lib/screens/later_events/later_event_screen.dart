import 'package:eventcountdown/screens/later_events/widgets/later_event_screen_body.dart';
import 'package:flutter/material.dart';

class LaterEventScreen extends StatelessWidget {
  const LaterEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LaterEventScreenBody(),
    );
  }
}
