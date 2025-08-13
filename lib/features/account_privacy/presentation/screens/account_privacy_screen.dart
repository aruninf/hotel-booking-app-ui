import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/account_privacy/presentation/controllers/account_privacy_controller.dart';
import 'package:nudge/features/push_notification_settings/presentation/screens/widgets/app_switch_tile.dart';

class AccountPrivacyScreen extends StatelessWidget {
  const AccountPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountPrivacyController>();
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Account Privacy',
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
                            Text(
                              'Set your account to private to limit access to approved users, or choose public to make your profile visible to everyone. You can change this setting at any time.',
                              style: TextStyle(color: AppColors.neutral600),
                            ),
                            AppSwitchTile(
                              value: controller.privateEnable.value,
                              title: 'Private Account',
                              textStyle: context.text.titleLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.neutral900,
                              ),
                              onChanged: (value) {
                                controller.privateEnable.value = value;
                              },
                            ),
                            const VerticalSpacing(18),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFB7BEC6),
                            ),
                            const VerticalSpacing(18),
                            Text(
                              'Blocked Users',
                              style: context.text.titleLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral900,
                              ),
                            ),
                            const VerticalSpacing(22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AppCachedImage(
                                      imgUrl: Assets.images.img7.path,
                                      height: 45,
                                      width: 45,
                                      errorWid: Image.asset(
                                        Assets.images.img7.path,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                    HorizontalSpacing(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'David Silbia',
                                          style: context.text.titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.color060518,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                AppOutlinedButton(
                                  text: "Unblock",
                                  textStyle: context.text.titleSmall!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                  height: 40,
                                  width: 87,
                                ),
                              ],
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
