import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/faqs/presentation/controllers/faqs_controller.dart';
import 'package:nudge/features/help/presentation/controllers/help_bindings.dart';
import 'package:nudge/features/help/presentation/screens/help_screen.dart';

class FaqsScreen extends GetView<FaqsController> {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FaqsController>();
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'FAQ\'s',
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ).copyWith(bottom: context.devicePaddingBottom + 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SearchTextfield(
                              title: 'Search',
                              fillColor: AppColors.colorWhite,
                              isSmallIcon: true,
                            ),
                            const VerticalSpacing(24),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: const BoxDecoration(
                                color: AppColors.baseWhite,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(bottom: 0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final item =
                                          controller.faqDataDetailList[index];
                                      return Column(
                                        children: [
                                          AppExpansionTile(
                                            title: item.title,
                                            description: item.description,
                                            titleNumber: item.titleNumber,
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(height: 1);
                                    },
                                    itemCount:
                                        controller.faqDataDetailList.length,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Need more help? ',
                                style: AppTextStyles.captionRegular,
                              ),
                              AppTextButton(
                                onTap: () {
                                  HelpInitializer.destroy();
                                  HelpInitializer.initialize();
                                  NavigationHelper.navigateWithFadeTransition(
                                    context,
                                    const HelpScreen(),
                                  );
                                },
                                fontSize: 12,
                                label: 'Contact us',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
