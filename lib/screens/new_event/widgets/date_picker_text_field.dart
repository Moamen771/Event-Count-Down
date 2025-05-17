import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class DateAndTimePickerField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final String pickerType; // "date" or "time"

  const DateAndTimePickerField({
    super.key,
    required this.controller,
    this.labelText,
    this.isEnabled = true,
    this.validator,
    this.pickerType = 'date',
  });

  void _showPicker(BuildContext context) {
    if (pickerType == 'date') {
      _showDayMonthYearPicker(context);
    } else if (pickerType == 'time') {
      _showTimePicker(context);
    }
  }

  void _showDayMonthYearPicker(BuildContext context) {
    final now = DateTime.now();
    int selectedDay = now.day;
    int selectedMonth = now.month;
    int selectedYear = now.year;

    final List<String> months = List.generate(
      12,
      (index) => DateFormat.MMM().format(DateTime(0, index + 1)),
    );

    final List<int> years = List.generate(
      51,
      (index) => now.year + index,
    );

    int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

    bool isValidDate() {
      if (selectedYear == now.year && selectedMonth == now.month) {
        return selectedDay >= now.day;
      }
      return true;
    }

    int getMinDay() {
      if (selectedYear == now.year && selectedMonth == now.month) {
        return now.day;
      }
      return 1;
    }

    List<Widget> getDaysWidgets() {
      final maxDay = daysInMonth(selectedYear, selectedMonth);

      return List.generate(
        maxDay,
        (index) => Center(child: Text((index + 1).toString())),
      );
    }

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: AppColors.whiteColor,
        child: Column(
          children: [
            CupertinoButton(
              child: const Text(
                "Select",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.darkColor,
                ),
              ),
              onPressed: () {
                if (isValidDate()) {
                  final date =
                      DateTime(selectedYear, selectedMonth, selectedDay);
                  final formatted = DateFormat('yyyy-MM-dd').format(date);
                  controller!.text = formatted;
                  Navigator.of(context).pop();
                } else {
                  final date = DateTime(now.year, now.month, now.day);
                  final formatted = DateFormat('yyyy-MM-dd').format(date);
                  controller!.text = formatted;
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Past date selected - Reset to today'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        List<Widget> dayWidgets = getDaysWidgets();
                        int initialDayIndex = selectedDay - 1;
                        if (initialDayIndex < 0) initialDayIndex = 0;
                        return CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialDayIndex,
                          ),
                          itemExtent: 32.0,
                          onSelectedItemChanged: (index) {
                            selectedDay = index + 1;

                            if (selectedYear == now.year &&
                                selectedMonth == now.month &&
                                selectedDay < now.day) {
                              setState(() {
                                selectedDay = now.day;
                              });
                            }
                          },
                          children: dayWidgets,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        int initialMonthIndex = selectedMonth - 1;

                        List<Widget> monthWidgets = [];
                        if (selectedYear == now.year) {
                          for (int i = now.month - 1; i < months.length; i++) {
                            monthWidgets.add(Center(child: Text(months[i])));
                          }
                          initialMonthIndex = 0; // First available month
                        } else {
                          monthWidgets = months
                              .map((month) => Center(child: Text(month)))
                              .toList();
                          initialMonthIndex = selectedMonth - 1;
                        }

                        return CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialMonthIndex,
                          ),
                          itemExtent: 32.0,
                          onSelectedItemChanged: (index) {
                            if (selectedYear == now.year) {
                              selectedMonth = index + now.month;
                            } else {
                              selectedMonth = index + 1;
                            }
                            setState(() {});
                          },
                          children: monthWidgets,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedYear - now.year,
                          ),
                          itemExtent: 32.0,
                          onSelectedItemChanged: (index) {
                            selectedYear = now.year + index;
                            setState(() {});
                          },
                          children: years
                              .map((year) =>
                                  Center(child: Text(year.toString())))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    final now = DateTime.now();
    DateTime selectedDateTime = DateTime.now();

    // Extract date from controller if available to check if it's today
    bool isToday = true;
    if (controller != null &&
        controller!.text.isNotEmpty &&
        pickerType == 'time') {
      // Try to get the date from another controller
      final eventDateController = controller!.text;
      try {
        // Get the current date for comparison
        final today = DateTime(now.year, now.month, now.day);
        isToday = true; // Default to today for validation
      } catch (e) {
        // If can't parse date, assume it's today for safety
        isToday = true;
      }
    }

    // Function to check if selected time is valid (not in the past)
    bool isValidTime() {
      if (!isToday) {
        // If not today, any time is valid
        return true;
      }

      // If today, compare with current time
      final currentTime = DateTime.now();
      return selectedDateTime.hour > currentTime.hour ||
          (selectedDateTime.hour == currentTime.hour &&
              selectedDateTime.minute >= currentTime.minute);
    }

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            CupertinoButton(
              child: const Text(
                "Select",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.darkColor,
                ),
              ),
              onPressed: () {
                if (!isToday || isValidTime()) {
                  final formatted =
                      DateFormat('HH:mm:ss').format(selectedDateTime);
                  controller!.text = formatted;
                  Navigator.of(context).pop();
                } else {
                  // Show snackbar for past time selection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot select a time in the past'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedDateTime,
                use24hFormat: true,
                minimumDate: isToday ? now : null,
                onDateTimeChanged: (DateTime dateTime) {
                  selectedDateTime = dateTime;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: labelText ?? "",
                style: const TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: "*",
                style: TextStyle(
                  color: Colors.red.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          validator: validator,
          enabled: isEnabled,
          readOnly: true,
          onTap: () {
            if (isEnabled) _showPicker(context);
          },
          controller: controller,
          cursorColor: AppColors.blackColor,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.arrow_drop_down_circle,
              color: AppColors.darkColor,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            fillColor: !isEnabled
                ? AppColors.lightColor
                : WidgetStateColor.transparent,
            filled: true,
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.whiteColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.darkColor),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.darkColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.darkColor, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
