import 'package:get/get.dart';
import 'package:nudge/features/invite_friends/data/source/invite_friends_remote_source.dart';
import 'package:nudge/features/invite_friends/presentation/controllers/invite_friends_controller.dart';

class InviteFriendsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => InviteFriendsRemoteSource(Get.find()))
      ..put(
        InviteFriendsController(
          remoteSource: Get.find<InviteFriendsRemoteSource>(),
        ),
      );
  }
}

class InviteFriendsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => InviteFriendsRemoteSource(Get.find()))
      ..put(
        InviteFriendsController(
          remoteSource: Get.find<InviteFriendsRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<InviteFriendsRemoteSource>()
      ..delete<InviteFriendsController>();
  }
}
