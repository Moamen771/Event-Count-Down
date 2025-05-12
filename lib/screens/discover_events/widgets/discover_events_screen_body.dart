import 'package:eventcountdown/models/online_events.dart';
import 'package:eventcountdown/screens/discover_events/widgets/online_events_list.dart';
import 'package:eventcountdown/services/api_service.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverEventsScreenBody extends StatelessWidget {
  DiscoverEventsScreenBody({super.key});

  final searchResult = <OnlineEvent>[].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          top: 10.0,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                spacing: 20,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Find events in',
                      filled: true,
                      fillColor: AppColors.lightColor,
                      suffixIcon: const Icon(
                        CupertinoIcons.search,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      search(value);
                    },
                  ),
                ],
              ),
            ),
            OnlineEventsList(onlineEvents: searchResult),
          ],
        ),
      ),
    );
  }

  search(searchTitle) async {
    final apiService = ApiService();
    searchResult.value = await apiService.loadEvents(searchTitle);
  }
}
