import 'package:get/get.dart';
import 'package:nudge/features/helpful_resources/data/source/helpful_resources_remote_source.dart';

class HelpfulResourcesController extends GetxController {
  HelpfulResourcesController({required this.remoteSource});

  final HelpfulResourcesRemoteSource remoteSource;
}
