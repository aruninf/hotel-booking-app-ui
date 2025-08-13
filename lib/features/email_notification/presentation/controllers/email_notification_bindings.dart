import 'package:get/get.dart';
import 'package:nudge/features/email_notification/data/source/email_notification_remote_source.dart';
import 'package:nudge/features/email_notification/presentation/controllers/email_notification_controller.dart';

class EmailNotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => EmailNotificationRemoteSource(Get.find()))
      ..put(
        EmailNotificationController(
          remoteSource: Get.find<EmailNotificationRemoteSource>(),
        ),
      );
  }
}

class EmailNotificationInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => EmailNotificationRemoteSource(Get.find()))
      ..put(
        EmailNotificationController(
          remoteSource: Get.find<EmailNotificationRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<EmailNotificationRemoteSource>()
      ..delete<EmailNotificationController>();
  }
}
