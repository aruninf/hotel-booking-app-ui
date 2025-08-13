import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nudge/features/login/data/source/login_remote_source.dart';

class LoginController extends GetxController {
  final LoginRemoteSource remoteSource;

  LoginController({required this.remoteSource});

  // Form key

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Focus nodes
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Reactive UI states
  final showEmailPrefixIcon = true.obs;
  final showPassword = true.obs;
  final showPasswordPrefixIcon = true.obs;
  final showPasswordSuffixIcon = false.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  // Update visibility of email prefix icon
  void _updateEmailPrefixIconVisibility() {
    showEmailPrefixIcon.value =
        !emailFocusNode.hasFocus && emailController.text.isEmpty;
  }

  // Update visibility of password prefix and suffix icons
  void _updatePasswordIconVisibility() {
    showPasswordPrefixIcon.value =
        !passwordFocusNode.hasFocus && passwordController.text.isEmpty;

    showPasswordSuffixIcon.value = passwordController.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();

    // Add listeners
    emailFocusNode.addListener(_updateEmailPrefixIconVisibility);
    emailController.addListener(_updateEmailPrefixIconVisibility);

    passwordFocusNode.addListener(_updatePasswordIconVisibility);
    passwordController.addListener(_updatePasswordIconVisibility);
  }

  @override
  void onClose() {
    // emailFocusNode.dispose();
    // passwordFocusNode.dispose();
    super.onClose();
  }
}
