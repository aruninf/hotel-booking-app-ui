import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/core/preferences/preferences.dart';
import 'package:nudge/core/preferences/shared_pref.dart';
import 'package:nudge/features/explainers/data/source/explainers_remote_source.dart';

class ExplainersController extends GetxController {
  ExplainersController({required this.remoteSource});

  final ExplainersRemoteSource remoteSource;
  Rx<int> currentPageIndex = 0.obs;
  final int totalPages = 3;
  final List<(String, String, String)> explainerData = [
    (
      Assets.images.explainerOnePhonePng.path,
      'Placeholder Title - This is placeholder text only ONE',
      ' This is placeholder ONE text only, intended for visual demonstration purposes only. ',
    ),
    (
      Assets.images.explainerTwoPhone.path,
      'Placeholder Title - This is placeholder text only TWO',
      ' This is placeholder TWO text only, intended for visual demonstration purposes only. ',
    ),
    (
      Assets.images.explainerThreePhone.path,
      'Placeholder Title - This is placeholder text only THREE',
      ' This is placeholder THREE text only, intended for visual demonstration purposes only. The content here is not meant to convey any specific information but to illustrate how text will appear in the final design. Please note that this text will be replaced with the approved content at the final stage.',
    ),
    // Assets.images.explainerTwoPhone.path,
    // Assets.images.explainerThreePhone.path,
  ];

  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  void nextPage() async {
    final prefs = Get.find<AppSharedPref>();
    if (currentPageIndex < 2) {
      currentPageIndex.value++;
    } else {
      await prefs.saveString(PreferenceKeys.hasSeenExplainer, 'true');
      Get.offAllNamed(AppRoutes.loginPage);
      // currentPageIndex.value = 0;
    }
    print('>>>>>>>>>>>>>>>>>CurrentPageIndex: $currentPageIndex');
  }
}
