import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final String pickerType; // "date" or "time"

  const DatePickerField({
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
      (index) => 2000 + index,
    );

    int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            CupertinoButton(
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.blackColor,
                ),
              ),
              onPressed: () {
                final date = DateTime(selectedYear, selectedMonth, selectedDay);
                final formatted = DateFormat('yyyy-MM-dd').format(date);
                controller!.text = formatted;
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedDay - 1,
                          ),
                          itemExtent: 32.0,
                          onSelectedItemChanged: (index) {
                            selectedDay = index + 1;
                          },
                          children: List.generate(
                            daysInMonth(selectedYear, selectedMonth),
                            (index) =>
                                Center(child: Text((index + 1).toString())),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMonth - 1,
                      ),
                      itemExtent: 32.0,
                      onSelectedItemChanged: (index) {
                        selectedMonth = index + 1;
                        if (selectedDay >
                            daysInMonth(selectedYear, selectedMonth)) {
                          selectedDay =
                              daysInMonth(selectedYear, selectedMonth);
                        }
                      },
                      children: months
                          .map((month) => Center(child: Text(month)))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedYear - 2000,
                      ),
                      itemExtent: 32.0,
                      onSelectedItemChanged: (index) {
                        selectedYear = 2000 + index;
                        if (selectedDay >
                            daysInMonth(selectedYear, selectedMonth)) {
                          selectedDay =
                              daysInMonth(selectedYear, selectedMonth);
                        }
                      },
                      children: years
                          .map((year) => Center(child: Text(year.toString())))
                          .toList(),
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
    DateTime selectedDateTime = DateTime.now();

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            CupertinoButton(
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.blackColor,
                ),
              ),
              onPressed: () {
                final formatted =
                    DateFormat('HH:mm:ss').format(selectedDateTime);
                controller!.text = formatted;
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedDateTime,
                use24hFormat: true,
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
        Text(
          labelText ?? "",
          style: const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
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
            suffixIcon: Icon(
              Icons.arrow_drop_down_circle,
              color: AppColors.primaryColor,
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
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.darkerColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.darkerColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.darkerColor, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
