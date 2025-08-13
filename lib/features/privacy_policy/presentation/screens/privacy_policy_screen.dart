import 'package:nudge/core/extension/extensions.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Privacy Policy',
          onTap: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            children: [
              Text(
                '1. Types data we collect',
                style: context.text.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.',
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                '2. Use if your personal data',
                style: context.text.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. ',
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const VerticalSpacing(22),
              Text(
                'Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.',
                style: context.text.bodyMedium!.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const VerticalSpacing(22),
            ],
          ),
        ),
      ),
    );
  }
}
