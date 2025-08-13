import 'package:get/get.dart';
import 'package:nudge/features/search/data/source/search_remote_source.dart';
import 'package:nudge/features/search/presentation/controllers/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SearchRemoteSource(Get.find()))
      ..put(SearchController(remoteSource: Get.find<SearchRemoteSource>()));
  }
}

class SearchInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => SearchRemoteSource(Get.find()))
      ..put(SearchController(remoteSource: Get.find<SearchRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<SearchRemoteSource>()
      ..delete<SearchController>();
  }
}
