import 'package:flutter/services.dart';
import 'package:nudge/core/extension/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.color,
    this.onTap,
    this.hideLeading = false,
    this.scrolledUnderElevation,
    this.actions,
    this.textStyle,
    this.backgroundColor = AppColors.transparent,
    this.systemOverlayStyle,
    this.heroTag,
    this.centerTitle,
  });

  final String? title;
  final String? heroTag;
  final Color? color;
  final Color backgroundColor;
  final void Function()? onTap;
  final double? scrolledUnderElevation;
  final List<Widget>? actions;
  final TextStyle? textStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool hideLeading;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    Widget appBar = AppBar(
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      foregroundColor: color,
      backgroundColor: backgroundColor,

      scrolledUnderElevation: scrolledUnderElevation,
      automaticallyImplyLeading: false,
      leading:
          hideLeading
              ? null
              : InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (onTap != null) {
                    onTap?.call();
                  } else {
                    Get.back();
                  }
                },
                child: Align(
                  child: Assets.images.backArrow.svg(
                    colorFilter:
                        textStyle?.color == AppColors.textColor50
                            ? const ColorFilter.mode(
                              AppColors.colorWhite,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                ),
              ),
      title:
          title != null
              ? Text(
                title!,
                style:
                    textStyle ??
                    context.text.displaySmall?.copyWith(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
              )
              : null,
      titleSpacing: 0,
      // centerTitle: false,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );

    return heroTag != null ? Hero(tag: heroTag!, child: appBar) : appBar;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
