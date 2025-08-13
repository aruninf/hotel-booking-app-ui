import 'package:get/get.dart';
import 'package:nudge/features/favourite_events/data/source/favourite_events_remote_source.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_controller.dart';

class FavouriteEventsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => FavouriteEventsRemoteSource(Get.find()))
      ..put(
        FavouriteEventsController(
          remoteSource: Get.find<FavouriteEventsRemoteSource>(),
        ),
      );
  }
}

class FavouriteEventsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => FavouriteEventsRemoteSource(Get.find()))
      ..put(
        FavouriteEventsController(
          remoteSource: Get.find<FavouriteEventsRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<FavouriteEventsRemoteSource>()
      ..delete<FavouriteEventsController>();
  }
}
