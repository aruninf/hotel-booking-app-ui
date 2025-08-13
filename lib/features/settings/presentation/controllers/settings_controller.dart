import 'package:get/get.dart';
import 'package:nudge/features/settings/data/source/settings_remote_source.dart';

class SettingsController extends GetxController {
  SettingsController({required this.remoteSource});

  final SettingsRemoteSource remoteSource;
}
