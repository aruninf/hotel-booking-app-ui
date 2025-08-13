import 'package:get/get.dart';
import 'package:nudge/features/places/data/source/places_remote_source.dart';
import 'package:nudge/features/places/presentation/controllers/places_controller.dart';

class PlacesBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => PlacesRemoteSource(Get.find()))
      ..put(PlacesController(remoteSource: Get.find<PlacesRemoteSource>()));
  }
}

class PlacesInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => PlacesRemoteSource(Get.find()))
      ..put(PlacesController(remoteSource: Get.find<PlacesRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<PlacesRemoteSource>()
      ..delete<PlacesController>();
  }
}
