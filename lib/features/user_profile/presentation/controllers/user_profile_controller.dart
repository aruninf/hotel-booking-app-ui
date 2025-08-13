import 'package:get/get.dart';
import 'package:nudge/features/user_profile/data/source/user_profile_remote_source.dart';

class UserProfileController extends GetxController {
  UserProfileController({required this.remoteSource});

  final UserProfileRemoteSource remoteSource;
}
