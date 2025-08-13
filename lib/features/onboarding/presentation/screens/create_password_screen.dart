import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return AppGradientScaffold(
      backgroundColor: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalSpacing(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create your password',
                      style: context.text.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    VerticalSpacing(30),
                    Obx(
                      () => Form(
                        key: controller.newPassKey,
                        child: Column(
                          children: [
                            Obx(
                              () => AppTextFormField(
                                enableInteractiveSelection: true,
                                labelText: 'Password',
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.neutral900,
                                ),
                                controller: controller.newPassword,
                                focusNode: controller.createPasswordFocusNode,
                                onChanged:
                                    (v) => controller.validatePassword(v),
                                obscureText: controller.showPassword.value,
                                prefixIcon:
                                    controller
                                            .showCreatePasswordPrefixIcon
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
                                            .showCreatePasswordSuffixIcon
                                            .value
                                        ? Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.seePassword();
                                            },
                                            icon: SvgPicture.asset(
                                              controller.showPassword.value
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
                            ),
                            VerticalSpacing(20),
                            Obx(
                              () => AppTextFormField(
                                labelText: 'Confirm password',
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.neutral900,
                                ),
                                controller: controller.confirmPassword,
                                focusNode:
                                    controller.createConfirmPasswordFocusNode,
                                onChanged:
                                    (val) => controller.validateForm(
                                      controller.newPassKey,
                                    ),
                                obscureText:
                                    controller.showConfirmPassword.value,
                                prefixIcon:
                                    controller
                                            .showCreateConfirmPasswordPrefixIcon
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
                                            .showCreateConfirmPasswordSuffixIcon
                                            .value
                                        ? Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.seeConfirmPassword();
                                            },
                                            icon: SvgPicture.asset(
                                              controller
                                                      .showConfirmPassword
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
                                    controller.newPassword.text.trim(),
                                  );
                                },
                                textInputType: TextInputType.visiblePassword,
                              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Opacity(
                          opacity:
                              controller.isPasswordValid.value &&
                                      controller.isFormValid.value &&
                                      controller.confirmPassword.text.isNotEmpty
                                  ? 1
                                  : 0.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.5,
                            ),
                            child: AppOutlinedButtonWithArrow(
                              onPressed: () {
                                if (!AppUtils.validateForm(
                                  controller.newPassKey,
                                )) {
                                  return;
                                }
                                if (controller.isPasswordValid.value &&
                                    controller.isFormValid.value &&
                                    controller
                                        .confirmPassword
                                        .text
                                        .isNotEmpty) {
                                  controller.moveToNextPage(
                                    controller.pageController.value.page!
                                        .toInt(),
                                  );
                                }
                              },
                              isLoading: false,
                              backgroundColor: AppColors.purpleButton,
                              textColor: Colors.green,
                              text: 'CONTINUE',
                              textStyle: context.text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                              height: 58,
                              width: 271,
                            ),
                          ),
                        ),
                      ),
                      VerticalSpacing(30),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(AppRoutes.loginPage);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: RichText(
                              text: TextSpan(
                                style: context.text.titleSmall?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.neutral600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Already have an account? '),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: context.text.titleMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.signupTextBtn,
                                    ),
                                  ),
                                ],
                              ),
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
