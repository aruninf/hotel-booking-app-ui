import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/preferences/preferences.dart';
import 'package:nudge/core/preferences/shared_pref.dart';
import 'package:nudge/features/explainers/presentation/controllers/explainers_bindings.dart';
import 'package:nudge/features/explainers/presentation/controllers/explainers_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExplainersScreen extends StatefulWidget {
  const ExplainersScreen({super.key});

  @override
  State<ExplainersScreen> createState() => _ExplainersScreenState();
}

class _ExplainersScreenState extends State<ExplainersScreen> {
  @override
  void initState() {
    ExplainersInitializer.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExplainersController>();
    final prefs = Get.find<AppSharedPref>();

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentPageIndex.value > 0) {
          controller.currentPageIndex.value--;
          return false; // Prevent default pop
        }
        return true; // Allow pop if already at first page
      },
      child: Scaffold(
        backgroundColor: AppColors.explainerBackground,
        body: Padding(
          padding: EdgeInsets.only(top: context.devicePaddingTop),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: context.deviceHeight * 0.02),
                  child: SizedBox(
                    height: context.deviceHeight * 0.6,
                    child: Obx(
                      () => Image.asset(
                        controller
                            .explainerData[controller.currentPageIndex.value]
                            .$1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.white.withAlpha(250),
                            AppColors.white.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.deepPurple,
                      ),
                      padding: EdgeInsets.only(
                        top: 70,
                        left: 31,
                        right: 31,
                        bottom: context.devicePaddingBottom + 18,
                      ),
                      width: Get.width,
                      child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) async {
                          final currentIndex =
                              controller.currentPageIndex.value;
                          final maxIndex = controller.totalPages - 1;
                          if (details.primaryVelocity! > 0) {
                            if (currentIndex > 0) {
                              controller.currentPageIndex.value--;
                            }
                          } else if (details.primaryVelocity! < 0) {
                            if (currentIndex < maxIndex) {
                              controller.currentPageIndex.value++;
                            } else if (currentIndex == maxIndex) {
                              await prefs.saveString(
                                PreferenceKeys.hasSeenExplainer,
                                'true',
                              );
                              // At last page, allow one more swipe to proceed
                              Get.offAllNamed(AppRoutes.loginPage);
                            }
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Text(
                                controller
                                    .explainerData[controller
                                        .currentPageIndex
                                        .value]
                                    .$2,
                                style: context.text.displaySmall?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            VerticalSpacing(25),
                            Obx(
                              () => Text(
                                controller
                                    .explainerData[controller
                                        .currentPageIndex
                                        .value]
                                    .$3,
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.splashContent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            VerticalSpacing(19),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await prefs.saveString(
                                      PreferenceKeys.hasSeenExplainer,
                                      'true',
                                    );
                                    Get.offAllNamed(AppRoutes.loginPage);
                                  },
                                  child: Text(
                                    'Skip',
                                    style: context.text.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white.withAlpha(175),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => AnimatedSmoothIndicator(
                                    activeIndex:
                                        controller.currentPageIndex.value,
                                    count: 3,
                                    effect: WormEffect(
                                      activeDotColor: AppColors.white,
                                      dotColor: AppColors.white.withAlpha(50),
                                      dotHeight: 8,
                                      dotWidth: 8,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => controller.nextPage(),
                                  child: Text(
                                    'Next',
                                    style: context.text.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // VerticalSpacing(context.devicePaddingBottom),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
