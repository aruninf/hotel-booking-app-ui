import 'package:flutter_svg/flutter_svg.dart';
import 'package:nudge/common/app_gradient_appbar.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/login/presentation/controllers/forgot_password_bindings.dart';
import 'package:nudge/features/login/presentation/controllers/forgot_password_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _resetPassKey = GlobalKey<FormState>(
    debugLabel: 'ResetPassKey',
  );

  @override
  void dispose() {
    Get.delete<ForgotPasswordController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

    // Set the email if it's passed from OTP screen
    if (Get.arguments != null) {
      controller.resetEmailController.text = Get.arguments.toString();
      // Validate the form and update the valid state
      final isValid = _resetPassKey.currentState?.validate() ?? false;
      controller.isResetFormValid.value = isValid;
    }
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.loginPage);
        return true;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppGradientAppBar(
            onBackTap: () {
              Get.offNamed(AppRoutes.loginPage);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(bottom: context.devicePaddingBottom, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot your password ',
                        style: context.text.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      VerticalSpacing(12),
                      Text(
                        'Please enter the email associated with your account.',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                      ),
                      VerticalSpacing(30),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _resetPassKey,
                        child: Obx(
                          () => AppTextFormField(
                            labelText: 'Your email',
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.neutral900,
                            ),
                            controller: controller.resetEmailController,
                            focusNode: controller.resetEmailFocusNode,
                            validator:
                                ValidationBuilder()
                                    .email('*Invalid Email')
                                    .required()
                                    .build(),
                            onChanged:
                                (value) => controller.validateForgotResetForm(
                                  _resetPassKey,
                                ),
                            prefixIcon:
                                controller.showForgotEmailPrefixIcon.value
                                    ? Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: SvgPicture.asset(
                                        Assets.images.messageIcon.path,
                                      ),
                                    )
                                    : null,
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                          ),
                        ),
                      ),
                      VerticalSpacing(30),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Opacity(
                          opacity: controller.isResetFormValid.value ? 1 : 0.5,
                          child: Center(
                            child: AppOutlinedButtonWithArrow(
                              onPressed: () {
                                final formIsValid =
                                    _resetPassKey.currentState?.validate() ??
                                    false;
                                controller.isResetFormValid.value = formIsValid;

                                if (!formIsValid) return;

                                final email =
                                    controller.resetEmailController.text.trim();

                                Get.toNamed(
                                  AppRoutes.otpScreen,
                                  arguments: email,
                                );
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
                          Get.offAllNamed(AppRoutes.onboarding);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: RichText(
                              text: TextSpan(
                                style: context.text.titleMedium?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.color120D26,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Don\'t have account? '),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: context.text.titleMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
