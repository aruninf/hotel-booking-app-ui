import 'package:get/get.dart';
import 'package:nudge/features/edit_profile/data/source/edit_profile_remote_source.dart';
import 'package:nudge/features/edit_profile/presentation/controllers/edit_profile_controller.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => EditProfileRemoteSource(Get.find()))
      ..put(
        EditProfileController(
          remoteSource: Get.find<EditProfileRemoteSource>(),
        ),
      );
  }
}

class EditProfileInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => EditProfileRemoteSource(Get.find()))
      ..put(
        EditProfileController(
          remoteSource: Get.find<EditProfileRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<EditProfileRemoteSource>()
      ..delete<EditProfileController>();
  }
}
