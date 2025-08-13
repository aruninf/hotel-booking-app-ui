import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/data/source/home_remote_source.dart';

class HomeController extends GetxController {
  HomeController({required this.remoteSource});

  final HomeRemoteSource remoteSource;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchSearchController = TextEditingController();
  TextEditingController chatSearchController = TextEditingController();
  TextEditingController mapSearchController = TextEditingController();

  void clearControllers() {
    searchController.clear();
    searchSearchController.clear();
    chatSearchController.clear();
    mapSearchController.clear();
  }
  // final RxSet<int> sentRequests = <int>{}.obs;

  // bool isRequestSent(int index) => sentRequests.contains(index);

  // void toggleRequestSent(int index) {
  //   if (sentRequests.contains(index)) {
  //     sentRequests.remove(index);
  //   } else {
  //     sentRequests.add(index);
  //   }
  // }
}
