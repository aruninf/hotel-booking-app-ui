import 'package:get/get.dart';
import 'package:nudge/features/onboarding/data/source/onboarding_remote_source.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class OnboardingBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => OnboardingRemoteSource(Get.find()))
      ..put(
        permanent: true,
        OnboardingController(remoteSource: Get.find<OnboardingRemoteSource>()),
      );
  }
}

class OnboardingInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => OnboardingRemoteSource(Get.find()))
      ..put(
        permanent: true,
        OnboardingController(remoteSource: Get.find<OnboardingRemoteSource>()),
      );
  }

  static void destroy() {
    Get
      ..delete<OnboardingRemoteSource>()
      ..delete<OnboardingController>();
  }
}
