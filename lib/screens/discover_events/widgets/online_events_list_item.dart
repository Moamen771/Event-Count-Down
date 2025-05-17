import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/online_events.dart';
import '../../../utils/app_colors.dart';

class OnlineEventsListItem extends StatelessWidget {
  const OnlineEventsListItem({super.key, required this.onlineEvent});

  final OnlineEvent onlineEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(onlineEvent.link),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Column(
            spacing: 10,
            children: [
              Image.network(
                onlineEvent.favicon,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Text(
                onlineEvent.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                onlineEvent.snippet,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
