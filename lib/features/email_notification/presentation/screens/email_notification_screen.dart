import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/email_notification/presentation/controllers/email_notification_controller.dart';
import 'package:nudge/features/push_notification_settings/presentation/screens/widgets/app_switch_tile.dart';

class EmailNotificationScreen extends GetView<EmailNotificationController> {
  const EmailNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Email Notifications',
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
                              value: controller.allEmailNotification.value,
                              title: 'All Email Notifications',
                              onChanged: (value) {
                                controller.toggleAllNotifications(value);
                              },
                              subtitle:
                                  'Manage your email notification preferences',
                            ),
                            const VerticalSpacing(18),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFB7BEC6),
                            ),
                            const VerticalSpacing(18),
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
