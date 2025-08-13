import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/change_password/data/source/change_password_remote_source.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController({required this.remoteSource});

  final ChangePasswordRemoteSource remoteSource;

  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  RxBool isPasswordValid = false.obs;
  RxBool showConfirmPassword = true.obs;
  RxBool showCurrentPassword = true.obs;
  RxBool showNewPassword = true.obs;

  RxBool containsNumber = false.obs;
  RxBool containsLetter = false.obs;
  RxBool containsSymbol = false.obs;
  RxBool isConfirmPassword = false.obs;
  RxBool hasMinLength = false.obs;
  RxBool showResetPassword = false.obs;
  RxBool isFormValid = false.obs;
  RxBool showCreatePasswordSuffixIcon = true.obs;

  @override
  void onInit() {
    super.onInit();

    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void validatePassword(String value) {
    hasMinLength.value = value.length >= 8;
    containsNumber.value = value.contains(RegExp(r'\d'));
    containsLetter.value = value.contains(RegExp(r'[A-Za-z]'));
    containsSymbol.value = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    isPasswordValid.value =
        hasMinLength.value &&
        containsNumber.value &&
        containsLetter.value &&
        containsSymbol.value;

    validateResetForm(formkey);
  }

  void validateResetForm(GlobalKey<FormState> formKey) {
    isFormValid.value = formKey.currentState?.validate() ?? false;
  }

  seeCurrentPassword() {
    showCurrentPassword.value = !showCurrentPassword.value;
  }

  seeNewPassword() {
    showNewPassword.value = !showNewPassword.value;
  }

  seeConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
