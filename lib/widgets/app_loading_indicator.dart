import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/app_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: AppColors.darkColor,
      size: 50,
    );
  }
}
