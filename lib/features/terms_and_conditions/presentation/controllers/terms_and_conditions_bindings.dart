import 'package:get/get.dart';
import 'package:nudge/features/terms_and_conditions/data/source/terms_and_conditions_remote_source.dart';
import 'package:nudge/features/terms_and_conditions/presentation/controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => TermsAndConditionsRemoteSource(Get.find()))
      ..put(
        TermsAndConditionsController(
          remoteSource: Get.find<TermsAndConditionsRemoteSource>(),
        ),
      );
  }
}

class TermsAndConditionsInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => TermsAndConditionsRemoteSource(Get.find()))
      ..put(
        TermsAndConditionsController(
          remoteSource: Get.find<TermsAndConditionsRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<TermsAndConditionsRemoteSource>()
      ..delete<TermsAndConditionsController>();
  }
}
