import 'package:eventcountdown/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() async {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.initialize();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsFlutterBinding,
  );
  FlutterNativeSplash.remove();
  runApp(
    const EventCountDown(),
  );
}
