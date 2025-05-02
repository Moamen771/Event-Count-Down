import 'package:eventcountdown/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required this.controller,
    this.validator,
    this.labelText,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null
            ? const SizedBox()
            : Text(
                labelText ?? "",
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
        Container(
          width: double.infinity,
          height: screenHeight * (1 / 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.darkerColor, width: 2),
          ),
          child: TextFormField(
            cursorColor: AppColors.primaryColor,
            controller: controller,
            validator: validator,

            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 16, horizontal: 12), // Adjust padding
            ),
            style: const TextStyle(
              color: AppColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ), // Optional: Adjust text style
          ),
        ),
      ],
    );
  }
}
