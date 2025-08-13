import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/edit_profile/data/source/edit_profile_remote_source.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.remoteSource});

  final EditProfileRemoteSource remoteSource;

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController dobController;
  late TextEditingController locationController;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController(text: 'Mary Williams');
    emailController = TextEditingController(text: 'Mary.williams@gmail.com');
    phoneNumberController = TextEditingController(text: '0454662398');
    dobController = TextEditingController(text: '23-02-2024');
    locationController = TextEditingController(text: 'Gold Coast, AUS');
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    dobController.dispose();

    super.onClose();
  }
}
