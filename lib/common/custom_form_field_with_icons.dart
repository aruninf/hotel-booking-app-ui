import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nudge/core/extension/extensions.dart';

class CustomFormFieldWithIcons extends StatelessWidget {
  const CustomFormFieldWithIcons({
    super.key,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.decoration,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.firstSuffixIcon,
    this.secondSuffixIcon,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onTap,
    this.isReadOnly = false,
    this.scroll = EdgeInsets.zero,
    this.autofocus = false,
    this.maxLines = 1,
    this.labelText,
    this.fillColor = AppColors.colorWhite,
    this.borderWidth = 1.0,
    this.hintStyle,
    this.autofillHints,
    this.focusedBorderColor = AppColors.neutral600,
    this.style,
    this.cursorHeight,
    this.maxLength,
    this.alignLabelWithHint = false,
    this.focusNode,
    this.onFirstIconTap,
    this.onSecondIconTap,
  });

  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final InputDecoration? decoration;
  final String? hintText;
  final Widget? firstSuffixIcon; // First SVG icon
  final Widget? secondSuffixIcon; // Second SVG icon
  final bool obscureText;
  final bool isReadOnly;
  final void Function()? onTap;
  final EdgeInsets scroll;
  final AutovalidateMode autovalidateMode;
  final TextInputAction textInputAction;
  final BorderRadius borderRadius;
  final bool autofocus;
  final int? maxLines;
  final String? labelText;
  final Color fillColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final double? cursorHeight;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool alignLabelWithHint;
  final void Function(String)? onChanged;
  final VoidCallback? onFirstIconTap; // Callback for the first icon
  final VoidCallback? onSecondIconTap; // Callback for the second icon

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      focusNode: focusNode,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      scrollPadding: scroll,
      readOnly: isReadOnly,
      onTap: () {
        onTap?.call();
      },
      obscureText: obscureText,
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      cursorHeight: cursorHeight,
      style: style,
      maxLength: maxLength,
      buildCounter:
          maxLength == null
              ? null
              : (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) {
                return Text(
                  '$currentLength/$maxLength words',
                  style: context.text.titleMedium!.copyWith(
                    color: AppColors.neutral600,
                    fontSize: 12.sp,
                  ),
                );
              },
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: fillColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.neutral50,
            width: borderWidth,
          ),
        ),
        alignLabelWithHint: alignLabelWithHint,
        hintStyle:
            hintStyle ??
            AppTextStyles.typography3Regular.copyWith(
              color: AppColors.neutral600,
            ),
        labelStyle: AppTextStyles.typography3Regular.copyWith(
          color: AppColors.neutral600,
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.neutral50,
            width: borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.colorRed),
        ),
        errorStyle: context.text.titleMedium!.copyWith(
          color: AppColors.colorRed,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(width: 2, color: AppColors.colorRed),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
        prefixIcon: prefixIcon,
        suffixIcon:
            (firstSuffixIcon != null || secondSuffixIcon != null)
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (firstSuffixIcon != null)
                      GestureDetector(
                        onTap: onFirstIconTap, // Trigger action for first icon
                        child: firstSuffixIcon!,
                      ),
                    if (firstSuffixIcon != null)
                      const SizedBox(width: 8), // Add space between icons
                    if (secondSuffixIcon != null)
                      GestureDetector(
                        onTap:
                            onSecondIconTap, // Trigger action for second icon
                        child: secondSuffixIcon!,
                      ),
                  ],
                )
                : null,
      ),
    );
  }
}
