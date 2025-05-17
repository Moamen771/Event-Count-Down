import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const RoundedTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    required this.keyboardType,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null
            ? const SizedBox()
            : RichText(
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
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          cursorColor: AppColors.darkColor,
          cursorHeight: 25,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
