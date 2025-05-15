import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventcountdown/screens/discover_events/discover_event_screen.dart';
import 'package:eventcountdown/screens/home/home_screen.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../later_events/later_event_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  List<Widget> screens = const [
    HomeScreen(),
    DiscoverEventsScreen(),
    LaterEventScreen(),
  ];
  final screenIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[screenIndex.value],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: AppColors.lightColor,
          index: screenIndex.value,
          height: 60,
          onTap: (value) {
            screenIndex.value = value;
          },
          items: const <Widget>[
            Icon(
              CupertinoIcons.home,
              color: AppColors.darkerColor,
            ),
            Icon(
              CupertinoIcons.search,
              color: AppColors.darkerColor,
            ),
            Icon(
              CupertinoIcons.calendar_circle,
              color: AppColors.darkerColor,
            ),
          ],
        ),
      ),
    );
  }
}
