import 'package:get/get.dart';
import 'package:nudge/features/login/data/source/login_remote_source.dart';
import 'package:nudge/features/login/presentation/controllers/forgot_password_controller.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => LoginRemoteSource(Get.find()))
      ..put(
        ForgotPasswordController(remoteSource: Get.find<LoginRemoteSource>()),
      );
  }
}

class ForgotPasswordInitializer {
  static void initialize() {
    Get.put(
      ForgotPasswordController(remoteSource: Get.find<LoginRemoteSource>()),
    );
  }

  static void destroy() {
    Get
      ..delete<LoginRemoteSource>()
      ..delete<ForgotPasswordController>();
  }
}
