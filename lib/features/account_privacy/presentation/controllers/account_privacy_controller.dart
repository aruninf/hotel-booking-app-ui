import 'package:get/get.dart';
import 'package:nudge/features/account_privacy/data/source/account_privacy_remote_source.dart';

class AccountPrivacyController extends GetxController {
  AccountPrivacyController({required this.remoteSource});

  final AccountPrivacyRemoteSource remoteSource;

  RxBool privateEnable = false.obs;
}
