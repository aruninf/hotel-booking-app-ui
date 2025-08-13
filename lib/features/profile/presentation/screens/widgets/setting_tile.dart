import 'package:nudge/core/extension/extensions.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({required this.title, super.key, this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.text.titleLarge!.copyWith(color: AppColors.neutral900),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.neutral900,
        size: 16,
      ),
    );
  }
}
