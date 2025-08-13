import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/invite_friends/data/source/invite_friends_remote_source.dart';

class InviteFriendsController extends GetxController {
  InviteFriendsController({required this.remoteSource});

  final InviteFriendsRemoteSource remoteSource;

  late TextEditingController linkController;
  late TextEditingController emailController;
  RxBool isCopied = false.obs;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    linkController = TextEditingController(text: 'Link.com.au');
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    linkController.dispose();

    super.onClose();
  }
}
