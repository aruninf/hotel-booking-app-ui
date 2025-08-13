import 'package:nudge/core/extension/extensions.dart';

class ThemedContainer extends StatelessWidget {
  const ThemedContainer({
    required this.child,
    super.key,
    this.radius = 20,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.width,
    this.border,
    this.alignment,
    this.height,
    this.color = AppColors.white,
    this.constraints,
    this.noShadow = false,
    this.clipBehavior = Clip.none,
  });

  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Alignment? alignment;
  final Color color;
  final BoxConstraints? constraints;
  final Clip clipBehavior;
  final bool noShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      alignment: alignment,
      width: width,
      height: height,
      constraints: constraints,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border ?? Border.all(color: AppColors.bgBorder),
      ),
      child: child,
    );
  }
}
