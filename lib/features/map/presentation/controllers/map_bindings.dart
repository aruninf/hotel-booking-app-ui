import 'package:get/get.dart';
import 'package:nudge/features/map/data/source/map_remote_source.dart';
import 'package:nudge/features/map/presentation/controllers/map_controller.dart';

class MapBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => MapRemoteSource(Get.find()))
      ..put(MapController(remoteSource: Get.find<MapRemoteSource>()));
  }
}

class MapInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => MapRemoteSource(Get.find()))
      ..put(MapController(remoteSource: Get.find<MapRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<MapRemoteSource>()
      ..delete<MapController>();
  }
}
