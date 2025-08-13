import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';

class AppOutlinedButtonWithArrow extends StatelessWidget {
  const AppOutlinedButtonWithArrow({
    required this.text,
    this.textStyle,
    super.key,
    this.onPressed,
    this.textColor = AppColors.colorWhite,
    this.backgroundColor,
    this.height = 52,
    this.progress,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor,
    this.borderRadius = 30,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  const AppOutlinedButtonWithArrow.lightBlue({
    required this.text,
    this.textStyle,
    super.key,
    this.progress,
    this.onPressed,
    this.textColor = AppColors.textColor50,
    this.backgroundColor,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary200,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  // old app buttonWhite
  const AppOutlinedButtonWithArrow.white({
    required this.text,
    this.textStyle,
    super.key,
    this.onPressed,
    this.progress,
    this.textColor = AppColors.textColor50,
    this.backgroundColor = AppColors.primary200,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary200,
    this.borderRadius = 16,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  const AppOutlinedButtonWithArrow.withOutlined({
    required this.text,
    this.progress,
    this.textStyle,
    super.key,
    this.onPressed,
    this.textColor = AppColors.primary500,
    this.backgroundColor = AppColors.white,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary500,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  const AppOutlinedButtonWithArrow.orange({
    required this.text,
    this.textStyle,
    super.key,
    this.progress,
    this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.appRed,
    this.height = 58,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  final String text;
  final void Function()? onPressed;
  final Color textColor;
  final Color? backgroundColor;

  final double? height;
  final double? width;
  final bool isLoading;
  final double borderRadius;
  final Color? borderColor;
  final double? progress;
  final bool hasShadow;
  final bool safePadding;
  final Widget? leading;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Padding(
      padding: safePadding ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          if (isEnabled) {
            HapticFeedback.lightImpact();
            AppUtils.unfocusKeyboard(context);
            onPressed?.call();
          }
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: isEnabled ? backgroundColor : AppColors.primary200,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color:
                  isEnabled
                      ? (borderColor ?? backgroundColor ?? Colors.transparent)
                      : Colors.transparent,
            ),
          ),
          child: Stack(
            children: [
              // 🔵 Progress fill background
              if (progress != null && progress! > 0)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress!.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary500,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(borderRadius),
                            right: Radius.circular(
                              progress! >= 0.95 ? borderRadius : 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // 🔤 Button content
              Center(
                child:
                    isLoading
                        ? const AppLoadingWidget.small(
                          color: AppColors.colorWhite,
                        )
                        : Stack(
                          alignment: Alignment.center,
                          children: [
                            // 🔤 Centered Text
                            Center(
                              child: Text(
                                text,
                                style:
                                    textStyle ??
                                    context.text.titleMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                              ),
                            ),

                            // 🔘 Arrow on the right
                            Positioned(
                              right: 14,
                              child: ClipOval(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  color: AppColors.white,
                                  padding: EdgeInsets.all(8.w),
                                  child: SvgPicture.asset(
                                    Assets.images.rightArrow.path,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),

                            // 👈 Optional: Leading icon on the left
                            if (leading != null)
                              Positioned(left: 14, child: leading!),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
