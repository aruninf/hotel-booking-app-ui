import 'package:nudge/core/extension/extensions.dart';

class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    required this.title,
    required this.value,
    super.key,
    this.onChanged,
    this.textStyle,
    this.subtitle,
  });

  final void Function(bool)? onChanged;
  final String title;
  final bool value;
  final TextStyle? textStyle;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              )
              : null,
      title: Text(
        title,
        style:
            textStyle ??
            context.text.bodyLarge!.copyWith(color: AppColors.neutral900),
      ),
      value: value,
      activeTrackColor: AppColors.foundationPrimary500,
      activeColor: AppColors.foundationPrimary500,
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      tileColor: Colors.transparent,
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
        if (states.contains(WidgetState.selected)) {
          return null;
        }
        return const Icon(Icons.circle, size: 16, color: Colors.white);
      }),
      onChanged: onChanged,
    );
  }
}
