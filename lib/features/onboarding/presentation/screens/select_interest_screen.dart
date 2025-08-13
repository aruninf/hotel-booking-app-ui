import 'package:nudge/common/custom_checkbox.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class SelectInterestScreen extends StatefulWidget {
  const SelectInterestScreen({super.key});

  @override
  State<SelectInterestScreen> createState() => _SelectInterestScreenState();
}

class _SelectInterestScreenState extends State<SelectInterestScreen> {
  final ScrollController _listController = ScrollController();

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        controller.moveToPreviousPage();
        return false;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.transparent,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(bottom: context.devicePaddingBottom + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(10),
                Text(
                  'Select your interests',
                  style: context.text.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.color120D26,
                  ),
                ),
                VerticalSpacing(30),
                SearchTextfield(
                  title: 'Search',
                  controller: controller.searchController,
                ),
                VerticalSpacing(30),
                Expanded(
                  child: Obx(() {
                    if (controller.filteredInterests.isEmpty) {
                      return Center(
                        child: Text(
                          "No skills available",
                          style: context.text.titleLarge?.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      );
                    }
                    return ScrollbarTheme(
                      data: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(
                          Colors.blueGrey.withOpacity(0.2),
                        ),
                        radius: const Radius.circular(50),
                      ),
                      child: Scrollbar(
                        controller: _listController,
                        radius: const Radius.circular(50),
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _listController,
                          padding: EdgeInsets.zero,
                          itemCount: controller.filteredInterests.length,
                          itemBuilder: (context, index) {
                            final skill = controller.filteredInterests[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCheckbox(
                                  title: skill.name,
                                  initialValue: skill.selected,
                                  onChanged: (value) {
                                    controller.toggleSelection(index);
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
                VerticalSpacing(5),
                if (!isKeyboardVisible)
                  Center(
                    child: AppOutlinedButtonWithArrow(
                      onPressed: () {
                        controller.moveToNextPage(
                          controller.pageController.value.page!.toInt(),
                        );
                      },
                      isLoading: false,
                      backgroundColor: AppColors.purpleButton,
                      textColor: Colors.green,
                      text: 'CONTINUE',
                      textStyle: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      height: 58,
                      width: 271,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
