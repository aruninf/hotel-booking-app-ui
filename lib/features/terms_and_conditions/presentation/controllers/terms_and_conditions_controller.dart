import 'package:get/get.dart';
import 'package:nudge/features/terms_and_conditions/data/source/terms_and_conditions_remote_source.dart';

class TermsAndConditionsController extends GetxController {
  TermsAndConditionsController({required this.remoteSource});

  final TermsAndConditionsRemoteSource remoteSource;
}
