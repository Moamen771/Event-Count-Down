// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocalNotificationsService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   // initialize
//   static Future init() async {
//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse) {},
//       onDidReceiveBackgroundNotificationResponse: (NotificationResponse) {},
//     );
//   }
//
// // Request Permission when initializing app
//   static Future<void> requestPermissionInitial() async {
//     // For Android 13+
//     if (await Permission.notification.isDenied) {
//       await Permission.notification.request();
//     }
//   }
//
//   // Request Permission
//   static Future<void> requestPermission(BuildContext context) async {
//     // For Android 13+
//     PermissionStatus status = await Permission.notification.request();
//
//     if (status.isDenied) {
//       // If denied, show dialog with instructions
//       _showSettingsDialog(context);
//     } else if (status.isPermanentlyDenied) {
//       // If permanently denied, direct to settings
//       _showSettingsDialog(context, permanentlyDenied: true);
//     }
//   }
//
//   static void _showSettingsDialog(BuildContext context,
//       {bool permanentlyDenied = false}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Enable Notifications"),
//         content: Text(permanentlyDenied
//             ? "Notifications are disabled permanently. Please go to settings to enable them."
//             : "You have denied notifications. Would you like to enable them in settings?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings(); // Opens the app settings screen
//             },
//             child: const Text("Open Settings"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // basic notification
//   static void showBasicNotification() async {
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         '1',
//         'channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         actions: <AndroidNotificationAction>[
//           AndroidNotificationAction(
//             'mark_read', // Action ID
//             'Mark as Read', // Button text
//           ),
//           AndroidNotificationAction(
//             'reply', // Action ID
//             'Reply', // Button text
//             inputs: <AndroidNotificationActionInput>[
//               AndroidNotificationActionInput(
//                   label: 'Type your reply...'), // Input field for reply
//             ],
//           ),
//         ],
//       ),
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       // id is used to identify the notification and must be unique and cancel notification
//       "Hello",
//       "Welcome to notifications",
//       notificationDetails,
//       payload: "Payload Data",
//     );
//   }
// }

//Todo: version 2
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocalNotificationsService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   // initialize
//   static Future init() async {
//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Foreground notification tap
//         debugPrint('Notification tapped (foreground): ${response.payload}');
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   }
//
//   // Request Permission when initializing app
//   static Future<void> requestPermissionInitial() async {
//     if (await Permission.notification.isDenied) {
//       await Permission.notification.request();
//     }
//   }
//
//   // Request Permission with dialog
//   static Future<void> requestPermission(BuildContext context) async {
//     PermissionStatus status = await Permission.notification.request();
//
//     if (status.isDenied) {
//       _showSettingsDialog(context);
//     } else if (status.isPermanentlyDenied) {
//       _showSettingsDialog(context, permanentlyDenied: true);
//     }
//   }
//
//   static void _showSettingsDialog(BuildContext context,
//       {bool permanentlyDenied = false}) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Enable Notifications"),
//         content: Text(permanentlyDenied
//             ? "Notifications are disabled permanently. Please go to settings to enable them."
//             : "You have denied notifications. Would you like to enable them in settings?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings(); // Opens app settings
//             },
//             child: const Text("Open Settings"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Basic notification with actions
//   static void showBasicNotification() async {
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         '1',
//         'channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//       ),
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       "Hello",
//       "Welcome to notifications",
//       notificationDetails,
//       payload: "Payload Data",
//     );
//   }
// }
//
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   debugPrint(
//       'Notification tapped in background: ${notificationResponse.payload}');
// }

//Todo: version 3
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class LocalNotificationsService {
//   // ... (other parts of the class remain unchanged)
//
//   // Call this once in your app's main() or init() to initialize timezone
//   static Future<void> configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }
//
//   // Scheduled notification
//   static Future<void> showScheduledNotification() async {
//     await configureLocalTimeZone(); // Make sure timezone is set
//
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         '2',
//         'scheduled_channel',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//       ),
//     );
//
//     // Schedule for 5 seconds later
//     final scheduledTime =
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1, // notification ID
//       'Scheduled Notification',
//       'This notification was scheduled to show after 5 seconds.',
//       scheduledTime,
//       notificationDetails,
//       androidAllowWhileIdle: true,
//       payload: 'Scheduled Payload',
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }

//TODO: version 4

import 'dart:async';
import 'package:eventcountdown/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification tapped (foreground): ${response.payload}');
      },
    );

    await _configureLocalTimeZone();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> requestPermissionInitial() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  static Future<void> requestPermission(BuildContext context) async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isDenied) {
      _showSettingsDialog(context);
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(context, permanentlyDenied: true);
    }
  }

  static void _showSettingsDialog(BuildContext context,
      {bool permanentlyDenied = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enable Notifications"),
        content: Text(permanentlyDenied
            ? "Notifications are permanently disabled. Please enable them in settings."
            : "Notifications are denied. Open settings to enable?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  static Future<void> showScheduledNotificationForEvent(Event event) async {
    tz.initializeTimeZones();
    final eventTime = DateTime.parse('${event.date} ${event.time}');
    final scheduledTime =
        tz.TZDateTime.from(eventTime.add(const Duration(seconds: 5)), tz.local);

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'event_channel',
        'Event Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      event.id ?? 0,
      'Event Ended',
      '${event.title} has just ended!',
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
