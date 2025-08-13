import 'package:get/get.dart';
import 'package:nudge/features/privacy_policy/data/source/privacy_policy_remote_source.dart';
import 'package:nudge/features/privacy_policy/presentation/controllers/privacy_policy_controller.dart';

class PrivacyPolicyBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => PrivacyPolicyRemoteSource(Get.find()))
      ..put(
        PrivacyPolicyController(
          remoteSource: Get.find<PrivacyPolicyRemoteSource>(),
        ),
      );
  }
}

class PrivacyPolicyInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => PrivacyPolicyRemoteSource(Get.find()))
      ..put(
        PrivacyPolicyController(
          remoteSource: Get.find<PrivacyPolicyRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<PrivacyPolicyRemoteSource>()
      ..delete<PrivacyPolicyController>();
  }
}
