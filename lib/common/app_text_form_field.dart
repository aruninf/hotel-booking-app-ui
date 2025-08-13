import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nudge/core/extension/extensions.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.decoration,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
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
    this.focusNode,
    this.alignLabelWithHint = false,
    this.onChanged,
    this.contentPadding,
    this.enableInteractiveSelection = true,
    this.contextMenuBuilder,
  });

  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final InputDecoration? decoration;
  final String? hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final bool isReadOnly;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final EdgeInsets scroll;
  final FocusNode? focusNode;
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
  final bool alignLabelWithHint;
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: enableInteractiveSelection,
      maxLines: maxLines,
      focusNode: focusNode,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      scrollPadding: scroll,
      readOnly: isReadOnly,
      onTap: () {
        onTap?.call();
      },
      onChanged: onChanged,
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
                  style: TextStyle(
                    color: AppColors.neutral600,
                    fontSize: 12.sp,
                  ),
                );
              },
      enableSuggestions: false,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        filled: true,
        isDense: true,
        fillColor: fillColor,
        hintText: hintText,
        alignLabelWithHint: alignLabelWithHint,
        hintStyle:
            hintStyle ??
            AppTextStyles.typography3Regular.copyWith(
              color: AppColors.neutral600,
            ),
        labelStyle: context.text.titleMedium!.copyWith(
          color: AppColors.neutral600,
        ),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.neutral50,
            width: borderWidth,
          ),
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        errorBorder: CustomOutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: AppColors.error500),
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          color: AppColors.error500,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: CustomOutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 2, color: AppColors.error500),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
        prefixIcon: prefixIcon,
        suffixIcon:
            suffixIcon == null
                ? null
                : Focus(
                  canRequestFocus: false,
                  descendantsAreFocusable: false,
                  child: suffixIcon!,
                ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 36,
          minWidth: 40,
        ),
      ),
    );
  }
}

class CustomOutlineInputBorder extends InputBorder {
  /// Creates an underline border for an [InputDecorator].
  ///
  /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
  /// null). Applications typically do not specify a [borderSide] parameter
  /// because the input decorator substitutes its own, using [copyWith], based
  /// on the current theme and [InputDecorator.isFocused].
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 4.0. The [borderRadius]
  /// parameter must not be null.
  const CustomOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
  });

  /// The radii of the border's rounded rectangle corners.
  ///
  /// When this border is used with a filled input decorator, see
  /// [InputDecoration.filled], the border radius defines the shape
  /// of the background fill as well as the bottom left and right
  /// edges of the underline itself.
  ///
  /// By default the top right and top left corners have a circular radius
  /// of 4.0.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  CustomOutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) {
    return CustomOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  CustomOutlineInputBorder scale(double t) {
    return CustomOutlineInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(
      Rect.fromLTWH(
        rect.left,
        rect.top,
        rect.width,
        math.max(0, rect.height - borderSide.width),
      ),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    final outer = borderRadius.toRRect(rect);
    final center = outer.deflate(borderSide.width / 2.0);
    canvas.drawRRect(center, paint);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorder && other.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;
}
