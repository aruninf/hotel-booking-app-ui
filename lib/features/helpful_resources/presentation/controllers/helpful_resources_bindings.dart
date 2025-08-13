import 'package:get/get.dart';
import 'package:nudge/features/helpful_resources/data/source/helpful_resources_remote_source.dart';
import 'package:nudge/features/helpful_resources/presentation/controllers/helpful_resources_controller.dart';

class HelpfulResourcesBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HelpfulResourcesRemoteSource(Get.find()))
      ..put(
        HelpfulResourcesController(
          remoteSource: Get.find<HelpfulResourcesRemoteSource>(),
        ),
      );
  }
}

class HelpfulResourcesInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => HelpfulResourcesRemoteSource(Get.find()))
      ..put(
        HelpfulResourcesController(
          remoteSource: Get.find<HelpfulResourcesRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<HelpfulResourcesRemoteSource>()
      ..delete<HelpfulResourcesController>();
  }
}
