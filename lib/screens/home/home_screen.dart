import 'package:eventcountdown/screens/home/widgets/home_screen_body.dart';
import 'package:eventcountdown/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(
          AppRouter.newEventScreen,
        ),
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }
}
