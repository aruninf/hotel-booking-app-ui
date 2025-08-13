import 'package:nudge/core/extension/extensions.dart';

class AppSelectedButton extends StatelessWidget {
  const AppSelectedButton({
    required this.selectedItem,
    required this.title,
    super.key,
  });

  final bool selectedItem;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (selectedItem)
              Container(
                width: 22,
                height: 22,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary500,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textColor200, width: 2),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
              )
            else
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.textColor200),
                ),
              ),
            const HorizontalSpacing(14),
            Text(
              title,
              style: context.text.titleMedium!.copyWith(
                fontSize: 16,
                color: AppColors.textColor200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
