import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/common/app_switch_tile.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({super.key});

  @override
  State<SetNotificationScreen> createState() => _SetNotificationScreenState();
}

class _SetNotificationScreenState extends State<SetNotificationScreen> {
  final controller = Get.find<OnboardingController>();

  void updateAllPushToggle() {
    final allOn =
        controller.notification1.value &&
        controller.notification2.value &&
        controller.notification3.value &&
        controller.notification4.value &&
        controller.notification5.value &&
        controller.notification6.value &&
        controller.notification7.value;

    controller.allPushNotification.value = allOn;
  }

  @override
  Widget build(BuildContext context) {
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
            ).copyWith(bottom: context.devicePaddingBottom + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(10),
                Container(
                  padding: const EdgeInsets.all(14),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.foundation50,
                  ),
                  child: Center(
                    child: SvgPicture.asset(Assets.images.bell.path),
                  ),
                ),
                VerticalSpacing(14),
                Text(
                  'Stay Informed',
                  style: context.text.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.color120D26,
                  ),
                ),
                VerticalSpacing(12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSwitchTile(
                            value: controller.allPushNotification.value,
                            title: 'All Push Notifications',
                            subtitle: 'Manage all your notification settings',
                            onChanged: (value) {
                              controller.allPushNotification.value = value;

                              controller.notification1.value = value;
                              controller.notification2.value = value;
                              controller.notification3.value = value;
                              controller.notification4.value = value;
                              controller.notification5.value = value;
                              controller.notification6.value = value;
                              controller.notification7.value = value;
                            },
                          ),
                          const VerticalSpacing(18),
                          const Divider(thickness: 1, color: Color(0xFFB7BEC6)),
                          const VerticalSpacing(18),
                          AppSwitchTile(
                            value: controller.notification1.value,
                            title: 'Notification 1',
                            onChanged: (value) {
                              controller.notification1.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification2.value,
                            title: 'Notification 2',
                            onChanged: (value) {
                              controller.notification2.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification3.value,
                            title: 'Notification 3',
                            onChanged: (value) {
                              controller.notification3.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification4.value,
                            title: 'Notification 4',
                            onChanged: (value) {
                              controller.notification4.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification5.value,
                            title: 'Notification 5',
                            onChanged: (value) {
                              controller.notification5.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification6.value,
                            title: 'Notification 6',
                            onChanged: (value) {
                              controller.notification6.value = value;
                              updateAllPushToggle();
                            },
                          ),
                          AppSwitchTile(
                            value: controller.notification7.value,
                            title: 'Notification 7',
                            onChanged: (value) {
                              controller.notification7.value = value;
                              updateAllPushToggle();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                VerticalSpacing(5),
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
                    text: 'SAVE',
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
