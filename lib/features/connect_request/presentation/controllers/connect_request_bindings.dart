import 'package:get/get.dart';
import 'package:nudge/features/connect_request/data/source/connect_request_remote_source.dart';
import 'package:nudge/features/connect_request/presentation/controllers/connect_request_controller.dart';

class ConnectRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => ConnectRequestRemoteSource(Get.find()))
      ..put(
        ConnectRequestController(
          remoteSource: Get.find<ConnectRequestRemoteSource>(),
        ),
      );
  }
}

class ConnectRequestInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => ConnectRequestRemoteSource(Get.find()))
      ..put(
        ConnectRequestController(
          remoteSource: Get.find<ConnectRequestRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<ConnectRequestRemoteSource>()
      ..delete<ConnectRequestController>();
  }
}
