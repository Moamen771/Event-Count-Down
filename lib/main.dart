import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';

void main() {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);
  FlutterNativeSplash.remove();
  runApp(const EventCountDown());
}
