import 'package:eventcountdown/screens/new_event/new_event_screen.dart';
import 'package:eventcountdown/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../screens/home/home_screen.dart';

class AppRouter {
  static const homeScreen = '/homeScreen';
  static const newEventScreen = '/newEventScreen';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRouter.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRouter.newEventScreen,
      builder: (context, state) => const NewEventScreen(),
    ),
  ],
);
