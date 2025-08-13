import 'package:nudge/common/bottom_modal_sheet.dart';
import 'package:nudge/core/constants/app_success_screen.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/setting_tile.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: context.text.titleLarge!.copyWith(
              color: AppColors.color8C9399,
              fontWeight: FontWeight.w500,
            ),
          ),
          VerticalSpacing(12),
          SettingTile(
            title: 'Edit profile',
            onTap: () {
              // EditProfileInitializer.destroy();
              // EditProfileInitializer.initialize();
              // NavigationHelper.navigateWithFadeTransition(
              //   context,
              //   const EditProfileScreen(),
              // );
              Get.toNamed(AppRoutes.editProfile);
            },
          ),
          SettingTile(
            title: 'Account Privacy',
            onTap: () {
              Get.toNamed(AppRoutes.accountPrivacy);
            },
          ),
          SettingTile(
            title: 'Change password',
            onTap: () {
              Get.toNamed(AppRoutes.changePassword);
            },
          ),
          SettingTile(
            title: 'Push Notifications',
            onTap: () {
              Get.toNamed(AppRoutes.pushNotification);
            },
          ),
          SettingTile(
            title: 'Email Notifications',
            onTap: () {
              Get.toNamed(AppRoutes.emailNotification);
            },
          ),
          // const VerticalSpacing(24),
          VerticalSpacing(12),
          Text(
            'More',
            style: context.text.titleLarge!.copyWith(
              color: AppColors.color8C9399,
              fontWeight: FontWeight.w500,
            ),
          ),
          VerticalSpacing(12),
          SettingTile(
            title: 'Invite Friends',
            onTap: () {
              Get.toNamed(AppRoutes.inviteFriends);
            },
          ),
          VerticalSpacing(12),
          SettingTile(
            title: 'Privacy policy',
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicy);
            },
          ),
          SettingTile(
            title: 'Terms and conditions',
            onTap: () {
              Get.toNamed(AppRoutes.termsAndConditions);
            },
          ),
          SettingTile(
            title: 'FAQ',
            onTap: () {
              // FaqsInitializer.destroy();
              // FaqsInitializer.initialize();
              // NavigationHelper.navigateWithFadeTransition(
              //   context,
              //   const FaqsScreen(),
              // );
              Get.toNamed(AppRoutes.faqs);
            },
          ),
          SettingTile(
            title: 'Help',
            onTap: () {
              Get.toNamed(AppRoutes.help);
            },
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Logout',
              style: AppTextStyles.bodyLGRegular.copyWith(
                color: AppColors.primary500,
              ),
            ),
            onTap: () {
              showCustomConfirmationBottomSheet(
                context: context,
                title: 'Log Out?',
                description:
                    'Are you sure you want to log out of your account?',
                confirmText: 'LOG OUT',
                onConfirm: () {
                  Get.offNamed(AppRoutes.loginPage);
                },
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Delete Account',
              style: AppTextStyles.bodyLGRegular.copyWith(
                color: AppColors.error500,
              ),
            ),
            onTap: () {
              showCustomConfirmationBottomSheet(
                context: context,
                title: 'Delete Account?',
                description:
                    'Once your account is deleted, all your data will be permanently removed.',
                confirmText: 'DELETE ACCOUNT',
                onConfirm: () {
                  Get.offNamed(
                    AppRoutes.successParam,
                    arguments: AppSuccessScreenParam(
                      title: 'Account Deleted',
                      subtitle:
                          'Your account has been successfully deleted! You can exit the app.',
                      image: Assets.images.successMark.path,
                      buttonText: 'EXIT',
                      onPressed: (context) {
                        Get.offNamed(AppRoutes.main);
                      },
                    ),
                  );
                },
              );
            },
          ),
          VerticalSpacing(100),
        ],
      ),
    );
  }
}
