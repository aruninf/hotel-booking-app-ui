import 'package:get/get.dart';
import 'package:nudge/features/chat/data/source/chat_remote_source.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => ChatRemoteSource(Get.find()))
      ..put(ChatController(remoteSource: Get.find<ChatRemoteSource>()));
  }
}

class ChatInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => ChatRemoteSource(Get.find()))
      ..put(ChatController(remoteSource: Get.find<ChatRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<ChatRemoteSource>()
      ..delete<ChatController>();
  }
}
