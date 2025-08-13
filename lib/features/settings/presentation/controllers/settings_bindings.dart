import 'package:get/get.dart';
import 'package:nudge/features/settings/data/source/settings_remote_source.dart';
import 'package:nudge/features/settings/presentation/controllers/settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SettingsRemoteSource(Get.find()))
      ..put(SettingsController(remoteSource: Get.find<SettingsRemoteSource>()));
  }
}

class SettingsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => SettingsRemoteSource(Get.find()))
      ..put(SettingsController(remoteSource: Get.find<SettingsRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<SettingsRemoteSource>()
      ..delete<SettingsController>();
  }
}
