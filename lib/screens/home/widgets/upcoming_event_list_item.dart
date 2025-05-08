import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/event.dart';

class UpComingEventListItem extends StatelessWidget {
  const UpComingEventListItem({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(event.date as String).toLocal();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.lightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            formattedDate,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
