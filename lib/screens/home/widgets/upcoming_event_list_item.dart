import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpComingEventListItem extends StatelessWidget {
  const UpComingEventListItem(
      {super.key,
      required this.title,
      required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.minute});

  final String title;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime(year, month, day, hour, minute);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
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
            title,
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
