import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/faqs/presentation/controllers/faqs_bindings.dart';
import 'package:nudge/features/faqs/presentation/screens/faqs_screen.dart';
import 'package:nudge/features/help/presentation/controllers/help_controller.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HelpController>();
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Help',
          onTap: () => Navigator.pop(context),
        ),
        body: LayoutBuilder(
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
                          const VerticalSpacing(20),
                          Text(
                            'If you have any questions, concerns, or need support, feel free to email us at:',
                            style: context.text.titleLarge!.copyWith(
                              color: AppColors.neutral900,
                            ),
                          ),
                          const VerticalSpacing(22),
                          AppTextFormField(
                            hintStyle: context.text.titleMedium!.copyWith(
                              color: AppColors.neutral600,
                            ),
                            labelText: 'Title',
                            controller: controller.titleController,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const VerticalSpacing(16),
                          AppTextFormField(
                            labelText: 'Write your message',
                            hintStyle: context.text.titleMedium!.copyWith(
                              color: AppColors.neutral600,
                            ),
                            controller: controller.writeMessageController,
                            textInputAction: TextInputAction.newline,
                            textInputType: TextInputType.multiline,
                            alignLabelWithHint: true,
                            maxLines: 8,
                          ),
                        ],
                      ),
                      if (!isKeyboardVisible)
                        Center(
                          child: Column(
                            children: [
                              AppOutlinedButton(
                                text: 'SUBMIT',
                                onPressed: () async {
                                  UiHelper.showloaderdialog(context);
                                  await Future.delayed(
                                    const Duration(seconds: 1),
                                  );
                                  Navigator.pop(Get.overlayContext!);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              const VerticalSpacing(19),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Check FAQs for quick answers.',
                                    style: AppTextStyles.captionRegular,
                                  ),
                                  AppTextButton(
                                    fontSize: 12,
                                    onTap: () {
                                      FaqsInitializer.destroy();
                                      FaqsInitializer.initialize();
                                      NavigationHelper.navigateWithFadeTransition(
                                        context,
                                        const FaqsScreen(),
                                      );
                                    },
                                    label: 'FAQ',
                                  ),
                                ],
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
    );
  }
}
