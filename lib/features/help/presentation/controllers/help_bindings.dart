import 'package:get/get.dart';
import 'package:nudge/features/help/data/source/help_remote_source.dart';
import 'package:nudge/features/help/presentation/controllers/help_controller.dart';

class HelpBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HelpRemoteSource(Get.find()))
      ..put(HelpController(remoteSource: Get.find<HelpRemoteSource>()));
  }
}

class HelpInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => HelpRemoteSource(Get.find()))
      ..put(HelpController(remoteSource: Get.find<HelpRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<HelpRemoteSource>()
      ..delete<HelpController>();
  }
}
