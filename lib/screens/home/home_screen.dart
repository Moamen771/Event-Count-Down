// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print("add event");
//         },
//         backgroundColor: eventContainerColor,
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 120,
//               margin: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: containerColor,
//               ),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: TimerCountdown(
//                   format: CountDownTimerFormat.daysHoursMinutesSeconds,
//                   endTime: DateTime.now().add(
//                     Duration(
//                       days: 1,
//                       hours: 5,
//                       minutes: 32,
//                       seconds: 59,
//                     ),
//                   ),
//                   timeTextStyle: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: textColor,
//                   ),
//                   colonsTextStyle: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: textColor,
//                   ),
//                   descriptionTextStyle: TextStyle(
//                     fontSize: 16,
//                     color: dateColor,
//                   ),
//                   onEnd: () {
//                     print("Timer finished");
//                   },
//                 ),
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     _buildEventCard(
//                       title: "Meeting with Team",
//                       year: 2025,
//                       month: 5,
//                       day: 10,
//                       hour: 14,
//                       minute: 30,
//                     ),
//                     _buildEventCard(
//                       title: "Doctor Appointment",
//                       year: 2025,
//                       month: 5,
//                       day: 12,
//                       hour: 9,
//                       minute: 0,
//                     ),
//                     _buildEventCard(
//                       title: "Gym Session",
//                       year: 2025,
//                       month: 5,
//                       day: 15,
//                       hour: 18,
//                       minute: 30,
//                     ),
//                     _buildEventCard(
//                       title: "Meeting with Team",
//                       year: 2025,
//                       month: 5,
//                       day: 10,
//                       hour: 14,
//                       minute: 30,
//                     ),
//                     _buildEventCard(
//                       title: "Doctor Appointment",
//                       year: 2025,
//                       month: 5,
//                       day: 12,
//                       hour: 9,
//                       minute: 0,
//                     ),
//                     _buildEventCard(
//                       title: "Gym Session",
//                       year: 2025,
//                       month: 5,
//                       day: 15,
//                       hour: 18,
//                       minute: 30,
//                     ),
//                     _buildEventCard(
//                       title: "Meeting with Team",
//                       year: 2025,
//                       month: 5,
//                       day: 10,
//                       hour: 14,
//                       minute: 30,
//                     ),
//                     _buildEventCard(
//                       title: "Doctor Appointment",
//                       year: 2025,
//                       month: 5,
//                       day: 12,
//                       hour: 9,
//                       minute: 0,
//                     ),
//                     _buildEventCard(
//                       title: "Gym Session",
//                       year: 2025,
//                       month: 5,
//                       day: 15,
//                       hour: 18,
//                       minute: 30,
//                     ),
//                     SizedBox(height: 70,)
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildEventCard({
//     required String title,
//     required int year,
//     required int month,
//     required int day,
//     required int hour,
//     required int minute,
//   }) {
//     DateTime dateTime = DateTime(year, month, day, hour, minute);
//     String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
//
//     return Container(
//       padding: EdgeInsets.all(16),
//       margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: eventContainerColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           )
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             formattedDate,
//             style: TextStyle(
//               color: dateColor,
//               fontSize: 16,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
