import 'package:get/get.dart';
import 'package:nudge/features/faqs/data/model/faqs_response.dart';
import 'package:nudge/features/faqs/data/source/faqs_remote_source.dart';

class FaqsController extends GetxController {
  FaqsController({required this.remoteSource});

  final FaqsRemoteSource remoteSource;
  final RxInt selectedIndex = 0.obs;

  List<String> items = ['General Info', 'App Features', 'Support'];

  RxList<FaqItemDetailsModel> faqDataDetailList = <FaqItemDetailsModel>[].obs;

  List<FaqItemDetailsModel> faqInfoList = [
    FaqItemDetailsModel(
      title: 'What do I do if I forget my password?',
      titleNumber: '01',
      description:
          'Tap "Forgot Password" on the login screen, and follow the instructions to reset it.',
    ),
    FaqItemDetailsModel(
      title: 'How do I update my profile information?',
      titleNumber: '02',
      description:
          'To update your profile information, go to the "Profile" section in the menu. Here, you can change your personal details such as your name, contact information, and preferences. Don’t forget to save changes once done!',
    ),
    FaqItemDetailsModel(
      title: 'How do I contact customer support?',
      titleNumber: '03',
      description:
          'You can contact customer support by visiting the "Contact Us" section in the app. You can choose to chat with a representative, send an email, or call our support hotline.',
    ),
    FaqItemDetailsModel(
      title: 'What kind of physiotherapy exercises are included?',
      titleNumber: '04',
      description:
          'Our physiotherapy exercises include a range of therapeutic movements and stretches aimed at improving mobility, strength, and flexibility. These exercises are customized based on individual needs and can be adjusted over time as you progress in your rehabilitation.',
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    faqDataDetailList.assignAll(faqInfoList);
  }
}
