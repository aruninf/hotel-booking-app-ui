import 'dart:async';

import 'package:nudge/core/extension/extensions.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();

  // final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>(debugLabel: 'otpFormKey');

  final RxBool isOtpFormValid = false.obs;
  final RxInt countdown = 30.obs;
  final RxBool canResend = false.obs;
  final RxBool isValidated = true.obs;
  final RxString otp = ''.obs;

  late TextEditingController resetEmailController;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    resetEmailController = TextEditingController();
    startOtpTimer(); // Start countdown when screen loads
  }

  void validateOtpForm(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    isOtpFormValid.value = isValid;
  }

  void validateOtpAndRoute(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      Get.offNamed(AppRoutes.resetPassword);
    }
  }

  void resendOtpCode() {
    if (!canResend.value) return;

    // Place your resend OTP API logic here

    startOtpTimer(); // restart countdown on resend
  }

  void startOtpTimer({int duration = 30}) {
    _timer?.cancel(); // Cancel any existing timer
    canResend.value = false;
    countdown.value = duration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value == 0) {
        timer.cancel();
        canResend.value = true;
      } else {
        countdown.value--;
      }
    });
  }

  @override
  void onClose() {
    pinController.dispose();
    resetEmailController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
