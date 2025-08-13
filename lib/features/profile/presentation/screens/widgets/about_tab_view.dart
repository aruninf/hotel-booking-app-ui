import 'package:nudge/common/custom_style_chip.dart';
import 'package:nudge/core/extension/extensions.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
      ).copyWith(bottom: context.devicePaddingBottom + 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Text(
            "Mary Wiiliams",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.titleColor,
            ),
          ),
          VerticalSpacing(10),
          GreyDivider(),
          VerticalSpacing(20),
          Text(
            "Email",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Text(
            "Mary.williams@gmail.com",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.titleColor,
            ),
          ),
          VerticalSpacing(10),
          GreyDivider(),
          VerticalSpacing(20),
          Text(
            "Phone Number",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Text(
            "0454662398",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.titleColor,
            ),
          ),
          VerticalSpacing(10),
          GreyDivider(),
          VerticalSpacing(20),
          Text(
            "Date of Birth",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Text(
            "23-02-2024",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.titleColor,
            ),
          ),
          VerticalSpacing(10),
          GreyDivider(),
          VerticalSpacing(20),
          Text(
            "Location",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Text(
            "Gold Coast,AUS",
            style: context.text.titleLarge!.copyWith(
              color: AppColors.titleColor,
            ),
          ),
          VerticalSpacing(10),
          GreyDivider(),
          VerticalSpacing(20),
          Text(
            "Interests",
            style: context.text.titleMedium!.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          VerticalSpacing(5),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              CustomStyledChip(label: "Business"),
              CustomStyledChip(label: "Design"),
              CustomStyledChip(label: "Technology"),
            ],
          ),
          VerticalSpacing(100),
        ],
      ),
    );
  }
}
