import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:nudge/features/onboarding/presentation/screens/create_password_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/enable_location_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/notification_success.dart';
import 'package:nudge/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/select_interest_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/set_notification_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/upload_photo_screen.dart';
import 'package:nudge/features/onboarding/presentation/screens/verify_phone_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with AutomaticKeepAliveClientMixin {
  // late PageController pageController;
  final controller = Get.find<OnboardingController>();

  // @override
  // void dispose() {
  //   controller.pageControllerDispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        final currentPage = controller.pageController.value.page?.round() ?? 0;
        if (currentPage == 0) {
          // Allow pop (swipe or back button will go to login)
          Get.offAllNamed(AppRoutes.loginPage);
          return true; // <-- allow Navigator to pop
        } else if (currentPage == 2) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  backgroundColor: AppColors.white,
                  title: Text("Are you sure?"),
                  content: Text(
                    "Do you want to discard the process and go back?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ),
          );
          if (shouldPop == true) {
            controller.pageController.value.jumpToPage(0);
            // Get.offAllNamed(AppRoutes.loginPage);
            return false; // allow pop
          }
          return false; // stay on current page
        } else {
          controller.moveToPreviousPage();
          return false; // don't pop, just go to previous onboarding page
        }
      },
      child: AppGradientScaffold(
        child: Padding(
          padding: EdgeInsets.only(top: context.devicePaddingTop),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final currentPage =
                          controller.pageController.value.page?.round();
                      if (currentPage == 2) {
                        final shouldPop = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                backgroundColor: AppColors.white,
                                title: Text("Are you sure?"),
                                content: Text(
                                  "Do you want to discard the process and go back?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back(result: true);
                                    },
                                    child: Text("Yes"),
                                  ),
                                ],
                              ),
                        );
                        if (shouldPop == true) {
                          controller.pageController.value.jumpToPage(0);
                          // Get.offAllNamed(AppRoutes.loginPage);
                        }
                        return;
                      }
                      if (currentPage == 0) {
                        Get.offAllNamed(AppRoutes.loginPage);
                        return;
                      }
                      controller.moveToPreviousPage();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.color111719,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: SmoothPageIndicator(
                          controller: controller.pageController.value,
                          count: 8,
                          // onDotClicked: (index) =>
                          //     controller.pageController.value.animateToPage(
                          //   index,
                          //   curve: Curves.linear,
                          //   duration: const Duration(milliseconds: 200),
                          // ),
                          effect: SlideEffect(
                            dotHeight: 6,
                            dotWidth: 20,
                            spacing: 4,
                            dotColor: AppColors.primary500.withAlpha(51),
                            activeDotColor: AppColors.primary500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    controller.pageIndex.value = value;
                  },
                  controller: controller.pageController.value,
                  children: [
                    const OnboardingScreen(),
                    const VerifyPhoneScreen(),
                    const CreatePasswordScreen(),
                    const UploadPhotoScreen(),
                    const SelectInterestScreen(),
                    const EnableLocationScreen(),
                    const SetNotificationScreen(),
                    const NotificationSuccess(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
