import 'package:flutter/services.dart';
import 'package:nudge/common/app_gradient_appbar.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/login/presentation/controllers/otp_controller.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>(
    debugLabel: 'otpFormKey',
  );

  @override
  Widget build(BuildContext context) {
    final otpControler = Get.find<OtpController>();
    final String email = Get.arguments?.toString() ?? '';

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   otpControler.validateOtpForm();
    // });
    return AppGradientScaffold(
      backgroundColor: AppColors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppGradientAppBar(
          onBackTap: () => Get.offNamed(AppRoutes.forgotPass),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ).copyWith(bottom: context.devicePaddingBottom),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please check your email ',
                      style: context.text.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    VerticalSpacing(12),
                    Text(
                      'We have sent code to $email',
                      style: context.text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral600,
                      ),
                    ),
                    VerticalSpacing(30),
                    Form(
                      key: _otpFormKey,
                      child: Pinput(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autofocus: true,
                        controller: otpControler.pinController,
                        onChanged:
                            (value) =>
                                otpControler.validateOtpForm(_otpFormKey),
                        onCompleted:
                            (value) =>
                                otpControler.validateOtpForm(_otpFormKey),
                        validator:
                            ValidationBuilder().minLength(4).required().build(),
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
                            color: AppColors.white,
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
                              color: AppColors.error500, // Red border for error
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalSpacing(41),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Opacity(
                        opacity: otpControler.isOtpFormValid.value ? 1 : 0.5,
                        child: Center(
                          child: AppOutlinedButtonWithArrow(
                            onPressed: () {
                              final isValid =
                                  _otpFormKey.currentState?.validate() ?? false;
                              otpControler.isOtpFormValid.value = isValid;

                              if (!isValid) return;

                              Get.toNamed(AppRoutes.resetPassword);
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
                        onTap: () => otpControler.resendOtpCode(),
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
                                          otpControler.countdown.value == 0
                                              ? ' Resend'
                                              : ' 00 : ${otpControler.countdown.value.toString().padLeft(2, '0')}',
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
