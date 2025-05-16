import 'package:eventcountdown/models/event.dart';
import 'package:eventcountdown/screens/discover_events/widgets/custom_timer.dart';
import 'package:eventcountdown/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ViewEventScreen extends StatelessWidget {
  const ViewEventScreen({super.key, required this.event});

  final Event event;

  DateTime _parseEventDateTime(String date, String time) {
    final dateParts = date.split('-').map(int.parse).toList();
    final timeParts = time.split(':').map(int.parse).toList();
    return DateTime(
      dateParts[0],
      dateParts[1],
      dateParts[2],
      timeParts[0],
      timeParts[1],
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.primaryColor),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveEvent = event;
    // final effectiveEvent = event ?? _dummyEvent;
    final targetDate =
        _parseEventDateTime(effectiveEvent.date, effectiveEvent.time);

    return Scaffold(
      appBar: AppBar(
        title: Text(effectiveEvent.title),
        backgroundColor: AppColors.darkGray,
        foregroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTimerCountdown(
                title: effectiveEvent.title,
                targetDate: targetDate,
                onEnd: () {},
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailTile(
                        icon: Icons.event,
                        title: "Event Title",
                        subtitle: effectiveEvent.title,
                      ),
                      _buildDetailTile(
                        icon: Icons.description,
                        title: "Description",
                        subtitle: effectiveEvent.description,
                      ),
                      _buildDetailTile(
                        icon: Icons.calendar_today,
                        title: "Date",
                        subtitle: effectiveEvent.date,
                      ),
                      _buildDetailTile(
                        icon: Icons.access_time,
                        title: "Time",
                        subtitle: effectiveEvent.time,
                      ),
                      _buildDetailTile(
                        icon: Icons.location_on,
                        title: "Location",
                        subtitle: effectiveEvent.location,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
