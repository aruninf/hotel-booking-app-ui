import 'package:flutter_svg/svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/change_password/presentation/controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePasswordController>();
    return CustomScaffold(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Change Password',
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(12),
                    Text(
                      'Please set up a new password.',
                      style: context.text.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral600,
                      ),
                    ),
                    VerticalSpacing(30),
                    Obx(
                      () => Form(
                        key: controller.formkey,
                        child: Column(
                          children: [
                            AppTextFormField(
                              labelText: 'Current Password',
                              controller: controller.currentPasswordController,
                              onChanged: (v) {
                                // controller.validatePassword(v);
                                controller.currentPasswordController.text = v;
                              },
                              obscureText: controller.showCurrentPassword.value,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  Assets.images.lockIcon.path,
                                ),
                              ),
                              suffixIcon:
                                  controller.showCreatePasswordSuffixIcon.value
                                      ? Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.seeCurrentPassword();
                                          },
                                          icon: SvgPicture.asset(
                                            controller.showCurrentPassword.value
                                                ? Assets.images.eye.path
                                                : Assets.images.eyeClose.path,
                                          ),
                                        ),
                                      )
                                      : null,
                              validator: ValidationBuilder().required().build(),
                              textInputType: TextInputType.visiblePassword,
                            ),
                            VerticalSpacing(20),
                            AppTextFormField(
                              labelText: 'New Password',
                              controller: controller.newPasswordController,
                              onChanged: (v) => controller.validatePassword(v),
                              obscureText: controller.showNewPassword.value,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  Assets.images.lockIcon.path,
                                ),
                              ),
                              suffixIcon:
                                  controller.showCreatePasswordSuffixIcon.value
                                      ? Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.seeNewPassword();
                                          },
                                          icon: SvgPicture.asset(
                                            controller.showNewPassword.value
                                                ? Assets.images.eye.path
                                                : Assets.images.eyeClose.path,
                                          ),
                                        ),
                                      )
                                      : null,
                              validator: ValidationBuilder().required().build(),
                              textInputType: TextInputType.visiblePassword,
                            ),
                            VerticalSpacing(20),
                            AppTextFormField(
                              labelText: 'Confirm password',
                              controller: controller.confirmPasswordController,
                              onChanged: (val) {
                                controller.isConfirmPassword.value = true;
                                controller.validateResetForm(
                                  controller.formkey,
                                );
                              },
                              obscureText: controller.showConfirmPassword.value,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: SvgPicture.asset(
                                  Assets.images.lockIcon.path,
                                ),
                              ),
                              suffixIcon:
                                  controller.showCreatePasswordSuffixIcon.value
                                      ? Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.seeConfirmPassword();
                                          },
                                          icon: SvgPicture.asset(
                                            controller.showConfirmPassword.value
                                                ? Assets.images.eye.path
                                                : Assets.images.eyeClose.path,
                                          ),
                                        ),
                                      )
                                      : null,
                              // validator: (value) => AppValidators.match(
                              //   value,
                              //   controller.newPasswordController.text.trim(),
                              // ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }

                                if (!controller.isConfirmPassword.value) {
                                  return null;
                                }

                                return AppValidators.match(
                                  value,
                                  controller.newPasswordController.text.trim(),
                                );
                              },

                              textInputType: TextInputType.visiblePassword,
                            ),
                            const VerticalSpacing(30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password Requirements',
                                  style: context.text.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutral900,
                                  ),
                                ),
                                const VerticalSpacing(14),
                                _buildValidationItem(
                                  'Must be at least 8 characters',
                                  controller.hasMinLength.value,
                                ),
                                const VerticalSpacing(14),
                                _buildValidationItem(
                                  'Must have at least one number',
                                  controller.containsNumber.value,
                                ),
                                const VerticalSpacing(14),
                                _buildValidationItem(
                                  'Must have at least one letter',
                                  controller.containsLetter.value,
                                ),
                                const VerticalSpacing(14),
                                _buildValidationItem(
                                  'Must have at least one symbol',
                                  controller.containsSymbol.value,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalSpacing(30),
                  ],
                ),
                Obx(
                  () => Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity:
                            controller.isPasswordValid.value &&
                                    controller.isFormValid.value &&
                                    controller.confirmPasswordController.text
                                        .trim()
                                        .isNotEmpty &&
                                    controller.currentPasswordController.text
                                        .trim()
                                        .isNotEmpty
                                ? 1
                                : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.5),
                          child: AppOutlinedButton(
                            text: 'CHANGE PASSWORD',
                            onPressed: () async {
                              if (controller.isPasswordValid.value &&
                                  controller.isFormValid.value) {
                                UiHelper.showloaderdialog(context);
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                Navigator.pop(Get.overlayContext!);
                                if (context.mounted) {
                                  Get.offNamed(AppRoutes.profile);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                isValid
                    ? Border.all(color: AppColors.greenCheck)
                    : Border.all(color: AppColors.textColor100),
            color: isValid ? AppColors.greenCheck : null,
          ),
          child: Icon(
            Icons.check,
            color: isValid ? Colors.white : Colors.transparent,
            size: 12,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          text,
          style: context.text.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.neutral900,
          ),
        ),
      ],
    );
  }
}
