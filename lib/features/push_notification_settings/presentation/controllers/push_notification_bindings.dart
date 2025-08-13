import 'package:get/get.dart';
import 'package:nudge/features/push_notification_settings/data/source/push_notification_settings_remote_source.dart';
import 'package:nudge/features/push_notification_settings/presentation/controllers/push_notification_controller.dart';

class PushNotificationSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => PushNotificationSettingsRemoteSource(Get.find()))
      ..put(
        PushNotificationSettingsController(
          remoteSource: Get.find<PushNotificationSettingsRemoteSource>(),
        ),
      );
  }
}

class PushNotificationSettingsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => PushNotificationSettingsRemoteSource(Get.find()))
      ..put(
        PushNotificationSettingsController(
          remoteSource: Get.find<PushNotificationSettingsRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<PushNotificationSettingsRemoteSource>()
      ..delete<PushNotificationSettingsController>();
  }
}
