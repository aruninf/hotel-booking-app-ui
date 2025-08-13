import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // late GlobalKey<FormState> newPassKey;

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final showNewPassword = true.obs;
  final showNewConfirmPassword = true.obs;

  final isPasswordValid = false.obs;
  final hasMinLength = false.obs;
  final containsNumber = false.obs;
  final containsLetter = false.obs;
  final containsSymbol = false.obs;

  RxBool isFormValid = false.obs;

  final newPasswordText = ''.obs;
  final confirmPasswordText = ''.obs;

  // Focus Nodes for the fields
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  // Reactive UI states for prefix icons
  final showNewPasswordPrefixIcon = true.obs;
  final showConfirmPasswordPrefixIcon = true.obs;
  final showNewPasswordSuffixIcon = false.obs;
  final showConfirmPasswordSuffixIcon = false.obs;

  @override
  void onInit() {
    super.onInit();
    // newPassKey = GlobalKey<FormState>(debugLabel: 'newpasswkey');
    // Add listeners for focus and text changes
    newPasswordFocusNode.addListener(_updateNewPasswordPrefixIconVisibility);
    confirmPasswordFocusNode.addListener(
      _updateConfirmPasswordPrefixIconVisibility,
    );

    newPasswordController.addListener(_updateNewPasswordPrefixIconVisibility);
    confirmPasswordController.addListener(
      _updateConfirmPasswordPrefixIconVisibility,
    );
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void seeNewPassword() {
    showNewPassword.value = !showNewPassword.value;
  }

  void seeNewConfirmPassword() {
    showNewConfirmPassword.value = !showNewConfirmPassword.value;
  }

  // Update visibility of new password prefix icon
  void _updateNewPasswordPrefixIconVisibility() {
    final isFocused = newPasswordFocusNode.hasFocus;
    final hasText = newPasswordController.text.isNotEmpty;
    // Hide icon when focused or text is not empty
    showNewPasswordPrefixIcon.value = !(isFocused || hasText);
    showNewPasswordSuffixIcon.value = isFocused || hasText;
  }

  // Update visibility of confirm password prefix icon
  void _updateConfirmPasswordPrefixIconVisibility() {
    // Hide icon when focused or text is not empty
    final isFocused = confirmPasswordFocusNode.hasFocus;
    final hasText = confirmPasswordController.text.isNotEmpty;

    showConfirmPasswordPrefixIcon.value = !(isFocused || hasText);
    showConfirmPasswordSuffixIcon.value = isFocused || hasText;
  }

  // Validate password input
  void validatePassword(String value) {
    newPasswordText.value = value;

    hasMinLength.value = value.length >= 8;
    containsNumber.value = value.contains(RegExp(r'\d'));
    containsLetter.value = value.contains(RegExp(r'[A-Za-z]'));
    containsSymbol.value = value.contains(
      RegExp(r'[!@#\$%^&*(),.?":{}|<>\[\]\\/~`_\-+=]'),
    );

    isPasswordValid.value =
        hasMinLength.value &&
        containsNumber.value &&
        containsLetter.value &&
        containsSymbol.value;

    validateResetForm(GlobalKey<FormState>());
  }

  // Validate the reset password form
  void validateResetForm(GlobalKey<FormState> formKey) {
    isFormValid.value = formKey.currentState?.validate() ?? false;
  }

  // Reset the password
  void resetPassword(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      // API Call or reset logic
      Get.snackbar("Success", "Password has been reset.");
    }
  }
}
