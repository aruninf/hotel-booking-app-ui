import 'package:get/get.dart';
import 'package:nudge/features/change_password/data/source/change_password_remote_source.dart';
import 'package:nudge/features/change_password/presentation/controllers/change_password_controller.dart';

class ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => ChangePasswordRemoteSource(Get.find()))
      ..put(
        ChangePasswordController(
          remoteSource: Get.find<ChangePasswordRemoteSource>(),
        ),
      );
  }
}

class ChangePasswordInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => ChangePasswordRemoteSource(Get.find()))
      ..put(
        ChangePasswordController(
          remoteSource: Get.find<ChangePasswordRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<ChangePasswordRemoteSource>()
      ..delete<ChangePasswordController>();
  }
}
