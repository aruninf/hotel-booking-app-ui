import 'package:get/get.dart';
import 'package:nudge/features/events/data/source/events_remote_source.dart';
import 'package:nudge/features/events/presentation/controllers/events_controller.dart';

class EventsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => EventsRemoteSource(Get.find()))
      ..put(EventsController(remoteSource: Get.find<EventsRemoteSource>()));
  }
}

class EventsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => EventsRemoteSource(Get.find()))
      ..put(EventsController(remoteSource: Get.find<EventsRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<EventsRemoteSource>()
      ..delete<EventsController>();
  }
}
