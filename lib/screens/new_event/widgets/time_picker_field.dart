import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class TimePickerField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final String pickerType; // "date" or "time" (only "time" is handled here)

  const TimePickerField({
    super.key,
    required this.controller,
    this.labelText,
    this.isEnabled = true,
    this.validator,
    this.pickerType = 'time',
  });

  void _showPicker(BuildContext context) {
    if (pickerType == 'time') {
      _showTimePicker(context);
    } else {
      // Optionally handle "date" picker or warn.
    }
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
                final formattedTime =
                    DateFormat('HH:mm:ss').format(selectedDateTime);
                controller?.text = formattedTime;
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
              Icons.access_time,
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
