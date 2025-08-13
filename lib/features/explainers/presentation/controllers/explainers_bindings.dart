import 'package:get/get.dart';
import 'package:nudge/features/explainers/data/source/explainers_remote_source.dart';
import 'package:nudge/features/explainers/presentation/controllers/explainers_controller.dart';

class ExplainersBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => ExplainersRemoteSource(Get.find()))
      ..put(
        ExplainersController(remoteSource: Get.find<ExplainersRemoteSource>()),
      );
  }
}

class ExplainersInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => ExplainersRemoteSource(Get.find()))
      ..put(
        ExplainersController(remoteSource: Get.find<ExplainersRemoteSource>()),
      );
  }

  static void destroy() {
    Get
      ..delete<ExplainersRemoteSource>()
      ..delete<ExplainersController>();
  }
}
