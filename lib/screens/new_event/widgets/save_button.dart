import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;

  const SaveButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lighterColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightColor,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
