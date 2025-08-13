import 'package:get/get.dart';
import 'package:nudge/features/user_profile/data/source/user_profile_remote_source.dart';
import 'package:nudge/features/user_profile/presentation/controllers/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => UserProfileRemoteSource(Get.find()))
      ..put(
        UserProfileController(
          remoteSource: Get.find<UserProfileRemoteSource>(),
        ),
      );
  }
}

class UserProfileInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => UserProfileRemoteSource(Get.find()))
      ..put(
        UserProfileController(
          remoteSource: Get.find<UserProfileRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<UserProfileRemoteSource>()
      ..delete<UserProfileController>();
  }
}
