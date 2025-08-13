import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/push_notification_settings/presentation/controllers/push_notification_controller.dart';
import 'package:nudge/features/push_notification_settings/presentation/screens/widgets/app_switch_tile.dart';

class PushNotificationSettingsScreen
    extends GetView<PushNotificationSettingsController> {
  const PushNotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Notifications',
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
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSwitchTile(
                              value: controller.allPushNotification.value,
                              title: 'All Push Notifications',
                              onChanged: (value) {
                                controller.toggleAllNotifications(value);
                              },
                              subtitle: 'Manage your notification preferences',
                            ),
                            const VerticalSpacing(18),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFB7BEC6),
                            ),
                            const VerticalSpacing(18),
                            // AppSwitchTile(
                            //   value: controller.notification1.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification1.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification2.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification2.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification3.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification3.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification4.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification4.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification5.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification5.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification6.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification6.value = value;
                            //   },
                            // ),
                            // AppSwitchTile(
                            //   value: controller.notification7.value,
                            //   title: 'Notification 1',
                            //   onChanged: (value) {
                            //     controller.notification7.value = value;
                            //   },
                            // ),
                            ...List.generate(
                              controller.notificationList.length,
                              (index) {
                                return AppSwitchTile(
                                  value:
                                      controller.notificationList[index].value,
                                  title: 'Notification 1',
                                  onChanged: (value) {
                                    controller.toggleSingleNotification(
                                      index,
                                      value,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: AppOutlinedButton(
                            text: 'SAVE CHANGES',
                            onPressed: () async {
                              UiHelper.showloaderdialog(context);
                              await Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(Get.overlayContext!);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
