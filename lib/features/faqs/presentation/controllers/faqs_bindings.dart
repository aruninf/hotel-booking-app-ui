import 'package:get/get.dart';
import 'package:nudge/features/faqs/data/source/faqs_remote_source.dart';
import 'package:nudge/features/faqs/presentation/controllers/faqs_controller.dart';

class FaqsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => FaqsRemoteSource(Get.find()))
      ..put(FaqsController(remoteSource: Get.find<FaqsRemoteSource>()));
  }
}

class FaqsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => FaqsRemoteSource(Get.find()))
      ..put(FaqsController(remoteSource: Get.find<FaqsRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<FaqsRemoteSource>()
      ..delete<FaqsController>();
  }
}
