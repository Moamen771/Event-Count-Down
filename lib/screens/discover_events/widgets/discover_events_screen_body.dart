// import 'package:eventcountdown/models/online_events.dart';
// import 'package:eventcountdown/screens/discover_events/widgets/online_events_list.dart';
// import 'package:eventcountdown/services/api_service.dart';
// import 'package:eventcountdown/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DiscoverEventsScreenBody extends StatelessWidget {
//   DiscoverEventsScreenBody({super.key});
//
//   final searchResult = <OnlineEvent>[].obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           right: 20.0,
//           left: 20.0,
//           top: 10.0,
//         ),
//         child: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Column(
//                 spacing: 20,
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Find events in',
//                       filled: true,
//                       fillColor: AppColors.lightColor,
//                       suffixIcon: const Icon(
//                         CupertinoIcons.search,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     onFieldSubmitted: (value) {
//                       search(value);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             OnlineEventsList(onlineEvents: searchResult),
//           ],
//         ),
//       ),
//     );
//   }
//
//   search(searchTitle) async {
//     final apiService = ApiService();
//     searchResult.value = (await apiService.loadEvents(searchTitle))!;
//   }
// }

import 'package:eventcountdown/models/online_events.dart';
import 'package:eventcountdown/screens/discover_events/widgets/online_events_list.dart';
import 'package:eventcountdown/screens/home/widgets/custom_app_bar.dart';
import 'package:eventcountdown/services/api_service.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:eventcountdown/widgets/app_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverEventsScreenBody extends StatelessWidget {
  DiscoverEventsScreenBody({super.key});

  final RxList<OnlineEvent> searchResult = <OnlineEvent>[].obs;
  final isLoading = false.obs;
  final hasSearched = false.obs;

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
                  const CustomAppBar(title: 'Discover Events'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Find events in',
                      filled: true,
                      fillColor: AppColors.lightColor,
                      suffixIcon: const Icon(CupertinoIcons.search),
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
                      if (value.trim().isNotEmpty) {
                        search(value.trim());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Obx(() {
              if (isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(
                    child: AppLoadingIndicator(),
                  ),
                );
              } else if (hasSearched.value && searchResult.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "No Result found",
                      style: TextStyle(
                        color: AppColors.darkerColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              } else if (searchResult.isNotEmpty) {
                return OnlineEventsList(onlineEvents: searchResult);
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                ); // Before first search
              }
            }),
          ],
        ),
      ),
    );
  }

  Future<void> search(String searchTitle) async {
    isLoading.value = true;
    hasSearched.value = true;
    try {
      final apiService = ApiService();
      final result = await apiService.loadEvents(searchTitle);
      searchResult.value = result ?? [];
    } finally {
      isLoading.value = false;
    }
  }
}
