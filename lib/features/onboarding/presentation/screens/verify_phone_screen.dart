import 'package:flutter/services.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:pinput/pinput.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final controller = Get.find<OnboardingController>();

  @override
  void initState() {
    controller.startTimer();

    super.initState();
  }

  @override
  void dispose() {
    controller.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String phone = controller.phoneController.text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.validateVerifyPhoneForm();
    });
    return WillPopScope(
      onWillPop: () async {
        controller.moveToPreviousPage();
        return true;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const VerticalSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify your phone number',
                        style: context.text.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.color120D26,
                        ),
                      ),
                      VerticalSpacing(12),
                      Text(
                        'We have sent code to $phone',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                      ),
                      VerticalSpacing(30),
                      Form(
                        key: controller.verifyPhoneKey,
                        child: Pinput(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          autofocus: true,
                          controller: controller.pinController,
                          onChanged:
                              (value) => controller.validateVerifyPhoneForm(),
                          // triggers on change
                          onCompleted:
                              (value) => controller.validateVerifyPhoneForm(),
                          // ensures complete input is valid
                          validator:
                              ValidationBuilder()
                                  .minLength(4)
                                  .required()
                                  .build(),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          errorTextStyle: context.text.titleSmall?.copyWith(
                            color: AppColors.error500,
                          ),
                          defaultPinTheme: PinTheme(
                            width: 68,
                            height: 68,
                            textStyle: context.text.displaySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: AppColors.neutral25,
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: AppColors.neutral50),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(
                                    0xFFE4E5E7,
                                  ).withAlpha(65), // soft shadow
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: 68,
                            height: 68,
                            textStyle: context.text.displaySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color:
                                    AppColors.error500, // Red border for error
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalSpacing(42),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Center(
                          child: Opacity(
                            opacity:
                                controller.isPhoneVerifyValid.value ? 1 : 0.5,
                            child: AppOutlinedButtonWithArrow(
                              onPressed: () {
                                controller.validateAndRoute();
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
                      VerticalSpacing(42),
                      Obx(
                        () => GestureDetector(
                          onTap: () => controller.resendCode(),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: context.text.titleMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color120D26,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Didn\'t get code?'),
                                      TextSpan(
                                        text:
                                            controller.countdown.value == 0
                                                ? ' Resend'
                                                : ' 00 : ${controller.countdown.value.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          color: AppColors.foundation500,
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
                      VerticalSpacing(30),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(AppRoutes.loginPage);
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: context.text.titleSmall?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral600,
                              ),
                              children: [
                                const TextSpan(
                                  // style: context.text.
                                  text: 'Already have an account? ',
                                ),
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
