import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/common/app_gradient_appbar.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/login/presentation/controllers/reset_password_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _newPassKey = GlobalKey<FormState>(
    debugLabel: 'newpasswkey',
  );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitConfirmationDialog(context);
        if (shouldPop ?? false) {
          Get.offAllNamed(AppRoutes.loginPage);
        }
        return false; // Prevent default back behavior
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppGradientAppBar(
            onBackTap: () async {
              final shouldPop = await _showExitConfirmationDialog(context);
              if (shouldPop ?? false) {
                Get.offAllNamed(AppRoutes.loginPage);
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(bottom: context.devicePaddingBottom),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset password',
                        style: context.text.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      VerticalSpacing(12),
                      Text(
                        'Please set up a new password.',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                      ),
                      VerticalSpacing(30),
                      Obx(
                        () => Form(
                          key: _newPassKey,
                          child: Column(
                            children: [
                              AppTextFormField(
                                // enableInteractiveSelection: false,
                                labelText: 'Password',
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.neutral900,
                                ),
                                controller: controller.newPasswordController,
                                focusNode: controller.newPasswordFocusNode,
                                onChanged:
                                    (v) => controller.validatePassword(v),
                                obscureText: controller.showNewPassword.value,
                                prefixIcon:
                                    controller.showNewPasswordPrefixIcon.value
                                        ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.images.lockIcon.path,
                                          ),
                                        )
                                        : null,
                                // Hide icon if condition is not met
                                suffixIcon:
                                    controller.showNewPasswordSuffixIcon.value
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
                                validator:
                                    ValidationBuilder().required().build(),
                                textInputType: TextInputType.visiblePassword,
                              ),
                              VerticalSpacing(20),
                              AppTextFormField(
                                // enableInteractiveSelection: false,
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.neutral900,
                                ),
                                labelText: 'Confirm password',
                                controller:
                                    controller.confirmPasswordController,
                                focusNode: controller.confirmPasswordFocusNode,
                                onChanged: (val) {
                                  controller.validateResetForm(_newPassKey);
                                },
                                obscureText:
                                    controller.showNewConfirmPassword.value,
                                prefixIcon:
                                    controller
                                            .showConfirmPasswordPrefixIcon
                                            .value
                                        ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                          ),
                                          child: SvgPicture.asset(
                                            Assets.images.lockIcon.path,
                                          ),
                                        )
                                        : null,
                                // Hide icon if condition is not met
                                suffixIcon:
                                    controller
                                            .showConfirmPasswordSuffixIcon
                                            .value
                                        ? Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: IconButton(
                                            onPressed: () {
                                              controller
                                                  .seeNewConfirmPassword();
                                            },
                                            icon: SvgPicture.asset(
                                              controller
                                                      .showNewConfirmPassword
                                                      .value
                                                  ? Assets.images.eye.path
                                                  : Assets.images.eyeClose.path,
                                            ),
                                          ),
                                        )
                                        : null,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null; // Don't validate yet
                                  }
                                  return AppValidators.match(
                                    value.trim(),
                                    controller.newPasswordController.text
                                        .trim(),
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
                                      controller
                                          .confirmPasswordController
                                          .text
                                          .isNotEmpty
                                  ? 1
                                  : 0.5,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.5,
                              ),
                              child: AppOutlinedButtonWithArrow(
                                onPressed: () {
                                  if (!AppUtils.validateForm(_newPassKey)) {
                                    return;
                                  }
                                  if (controller.isPasswordValid.value &&
                                      controller.isFormValid.value &&
                                      controller
                                          .confirmPasswordController
                                          .text
                                          .isNotEmpty) {
                                    Get.toNamed(AppRoutes.success);
                                  }
                                },
                                isLoading: false,
                                backgroundColor: AppColors.purpleButton,
                                textColor: Colors.green,
                                text: 'CONFIRM',
                                textStyle: context.text.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                                height: 58,
                              ),
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
            color: isValid ? AppColors.greenCheck : null, // Background color
          ),
          child: Icon(
            Icons.check,
            color: isValid ? Colors.white : Colors.transparent, // Tick color
            size: 12,
          ),
        ),
        const SizedBox(width: 8),
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

Future<bool?> _showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        title: Text("Are you sure?"),
        content: Text("Do you want to discard the process and go back?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text("Yes"),
          ),
        ],
      );
    },
  );
}
