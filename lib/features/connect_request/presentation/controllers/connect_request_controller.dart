import 'package:get/get.dart';
import 'package:nudge/features/connect_request/data/source/connect_request_remote_source.dart';

class ConnectRequestController extends GetxController {
  ConnectRequestController({required this.remoteSource});

  final ConnectRequestRemoteSource remoteSource;
}
