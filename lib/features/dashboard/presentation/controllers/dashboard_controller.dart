import 'package:get/get.dart';
import 'package:nudge/features/dashboard/data/source/dashboard_remote_source.dart';

class DashboardController extends GetxController {
  DashboardController({required this.remoteSource});

  final DashboardRemoteSource remoteSource;
  RxInt bottomNavIndex = 0.obs;
}
