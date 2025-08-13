import 'package:nudge/core/extension/extensions.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    required this.title,
    super.key,
    this.fillColor = AppColors.white,
    this.isSmallIcon = false,
    this.controller,
  });

  final String title;
  final Color fillColor;
  final bool isSmallIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return AppTextFormFieldWithoutLabel(
      controller: controller,
      borderRadius: BorderRadius.circular(16),
      borderWidth: 1,
      hintText: title,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 8, left: 16),
        child: Assets.images.searchTool.svg(),
      ),
      fillColor: fillColor,
    );
  }
}
