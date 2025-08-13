import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/help/data/source/help_remote_source.dart';

class HelpController extends GetxController {
  HelpController({required this.remoteSource});

  final HelpRemoteSource remoteSource;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController writeMessageController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    writeMessageController.dispose();
  }
}
