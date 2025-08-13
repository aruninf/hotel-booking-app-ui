import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class NotificationSuccess extends StatelessWidget {
  const NotificationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return WillPopScope(
      onWillPop: () async {
        controller.moveToPreviousPage();
        return false;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        bottomLogo: true,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: EdgeInsets.only(left: 34, right: 33).copyWith(
              top: context.devicePaddingTop + 31,
              bottom: context.devicePaddingBottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.images.circleCheck.path),
                  VerticalSpacing(30),
                  Text(
                    'Notifications saved!',
                    style: context.text.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpacing(12),
                  Text(
                    'Your notification settings has been saved successfully.',
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpacing(30),
                  AppOutlinedButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.dashboard);
                    },
                    isLoading: false,
                    backgroundColor: AppColors.purpleButton,
                    textColor: Colors.green,
                    text: 'GO TO HOME PAGE',
                    textStyle: context.text.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                    height: 58,
                    width: 271,
                  ),
                  VerticalSpacing(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
