import 'package:get/get.dart';
import 'package:nudge/features/privacy_policy/data/source/privacy_policy_remote_source.dart';

class PrivacyPolicyController extends GetxController {
  PrivacyPolicyController({required this.remoteSource});

  final PrivacyPolicyRemoteSource remoteSource;
}
