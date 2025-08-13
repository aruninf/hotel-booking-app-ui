import 'package:get/get.dart';
import "package:nudge/features/login/data/source/login_remote_source.dart"; // Import LoginRemoteSource
import 'package:nudge/features/login/presentation/controllers/reset_password_controller.dart';

class ResetPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(
        () => LoginRemoteSource(Get.find()),
      ) // Lazy load the LoginRemoteSource
      ..put(
        ResetPasswordController(), // Put OTP Controller
      );
  }
}

class OtpInitializer {
  static void initialize() {
    Get
      ..lazyPut(
        () => LoginRemoteSource(Get.find()),
      ) // Lazy load the LoginRemoteSource
      ..put(
        ResetPasswordController(), // Put OTP Controller
      );
  }

  static void destroy() {
    Get
      ..delete<LoginRemoteSource>() // Delete the LoginRemoteSource
      ..delete<ResetPasswordController>(); // Delete OTP Controller
  }
}
