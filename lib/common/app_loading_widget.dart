import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nudge/core/constants/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.size = 52,
    this.color = AppColors.primary500,
  });

  const AppLoadingWidget.small({
    super.key,
    this.size = 36,
    this.color = AppColors.primary500,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(color: color, size: size),
    );
  }
}
