import 'package:get/get.dart';
import 'package:nudge/features/home/data/source/home_remote_source.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';
import 'package:nudge/features/profile/data/source/profile_remote_source.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HomeRemoteSource(Get.find()))
      ..lazyPut(() => ProfileRemoteSource(Get.find()))
      ..put(HomeController(remoteSource: Get.find<HomeRemoteSource>()))
      ..put(ProfileController(remoteSource: Get.find<ProfileRemoteSource>()));
  }
}

class HomeInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => HomeRemoteSource(Get.find()))
      ..lazyPut(() => ProfileRemoteSource(Get.find()))
      ..put(HomeController(remoteSource: Get.find<HomeRemoteSource>()))
      ..put(ProfileController(remoteSource: Get.find<ProfileRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<HomeRemoteSource>()
      ..delete<HomeController>()
      ..delete<ProfileRemoteSource>()
      ..delete<ProfileController>();
  }
}
