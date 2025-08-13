import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nudge/features/login/data/source/login_remote_source.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController({required this.remoteSource});

  final LoginRemoteSource remoteSource;

  // final resetPassKey = GlobalKey<FormState>(debugLabel: 'ResetpAsswkey');
  late TextEditingController resetEmailController;
  late FocusNode resetEmailFocusNode;

  final showForgotEmailPrefixIcon = true.obs;
  final isResetFormValid = false.obs;

  void _updateResetEmailPrefixIconVisibility() {
    showForgotEmailPrefixIcon.value =
        !resetEmailFocusNode.hasFocus && resetEmailController.text.isEmpty;
  }

  void validateForgotResetForm(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    isResetFormValid.value = isValid;
  }

  @override
  void onInit() {
    super.onInit();
    resetEmailController = TextEditingController();
    resetEmailFocusNode = FocusNode(debugLabel: 'resetemail');

    resetEmailFocusNode.addListener(_updateResetEmailPrefixIconVisibility);
    resetEmailController.addListener(_updateResetEmailPrefixIconVisibility);

    // Clear the text field when controller is initialized
    resetEmailController.clear();
    isResetFormValid.value = false;
  }

  @override
  void onClose() {
    resetEmailController.dispose();
    resetEmailFocusNode.dispose();
    super.onClose();
  }
}
