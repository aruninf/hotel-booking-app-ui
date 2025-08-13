import 'package:get/get.dart';
import 'package:nudge/features/login/data/source/login_remote_source.dart';
import 'package:nudge/features/login/presentation/controllers/reset_global_controller.dart';

class ResetGlobalInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => LoginRemoteSource(Get.find()))
      ..put(ResetGlobalController());
  }

  static void destroy() {
    Get.delete<ResetGlobalController>();
  }
}
