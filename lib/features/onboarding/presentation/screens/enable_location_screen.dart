import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({super.key});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
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
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(bottom: context.devicePaddingBottom),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VerticalSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(22),
                        height: 94,
                        width: 94,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.foundation50,
                        ),
                        child: Center(
                          child: Assets.images.locationPng.image(
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      VerticalSpacing(14),
                      Text(
                        'Enable Location Services',
                        style: context.text.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.color120D26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacing(12),
                      Text(
                        'Turn on location access so Nudge can find nearby and relevant events for you. You’re always in control of your settings.',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacing(30),
                      Obx(() {
                        final granted = controller.isLocationGranted.value;
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.5,
                            ),
                            child: AppOutlinedButton(
                              onPressed: () async {
                                var status =
                                    await Permission.location.request();
                                if (status.isGranted) {
                                  // Update the state when permission is granted
                                  controller.isLocationGranted.value = true;
                                  controller.moveToNextPage(
                                    controller.pageController.value.page!
                                        .toInt(),
                                  );
                                } else if (status.isDenied) {
                                  await Permission.location.request();
                                } else if (status.isPermanentlyDenied) {
                                  // Optionally handle permanently denied status
                                  openAppSettings();
                                }
                              },
                              isLoading: false,
                              backgroundColor: AppColors.purpleButton,
                              textColor: Colors.green,
                              text: granted ? 'ALLOWED' : 'ALLOW LOCATION',
                              textStyle: context.text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                              height: 58,
                            ),
                          ),
                        );
                      }),
                      VerticalSpacing(30),
                      Obx(() {
                        final granted = controller.isLocationGranted.value;
                        return Center(
                          child: SizedBox(
                            width: 120,
                            child: TextButton(
                              onPressed: () async {
                                if (granted) {
                                  openAppSettings();
                                } else {
                                  controller.moveToNextPage(
                                    controller.pageController.value.page!
                                        .toInt(),
                                  );
                                }
                              },
                              child: Text(
                                granted ? 'Cancel' : 'Not Now',
                                style: context.text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      VerticalSpacing(42),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
