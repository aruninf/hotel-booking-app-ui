import 'package:get/get.dart';
import 'package:nudge/features/account_privacy/data/source/account_privacy_remote_source.dart';
import 'package:nudge/features/account_privacy/presentation/controllers/account_privacy_controller.dart';

class AccountPrivacyBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => AccountPrivacyRemoteSource(Get.find()))
      ..put(
        AccountPrivacyController(
          remoteSource: Get.find<AccountPrivacyRemoteSource>(),
        ),
      );
  }
}

class AccountPrivacyInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => AccountPrivacyRemoteSource(Get.find()))
      ..put(
        AccountPrivacyController(
          remoteSource: Get.find<AccountPrivacyRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<AccountPrivacyRemoteSource>()
      ..delete<AccountPrivacyController>();
  }
}
