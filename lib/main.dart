import 'package:eventcountdown/screens/new_event/new_event_screen.dart';
import 'package:eventcountdown/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationsService.init();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsFlutterBinding,
  );
  FlutterNativeSplash.remove();
  runApp(const EventCountDown());
}

class EventCountDown extends StatelessWidget {
  const EventCountDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewEventScreen(),
    );
  }
}
