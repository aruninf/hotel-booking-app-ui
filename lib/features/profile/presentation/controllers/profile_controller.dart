import 'package:get/get.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';
import 'package:nudge/features/profile/data/source/profile_remote_source.dart';
import 'package:nudge/gen/assets.gen.dart';

class ProfileController extends GetxController {
  ProfileController({required this.remoteSource});

  final ProfileRemoteSource remoteSource;

  // Rx list of events
  RxList<Event> events = <Event>[].obs;

  // Rx list of connections
  RxList<Connection> connections = <Connection>[].obs;
  final RxSet<int> sentRequests = <int>{}.obs;

  bool isRequestSent(int index) => sentRequests.contains(index);

  @override
  void onInit() {
    super.onInit();
    loadEvents();
    loadConnections();
  }

  void toggleRequestSent(int index) {
    if (sentRequests.contains(index)) {
      sentRequests.remove(index);
    } else {
      sentRequests.add(index);
    }
  }

  void loadEvents() {
    // Example: loading dummy events. You can replace this with an API call later.
    events.value = [
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Wed, Apr 28',
        time: '5:30 PM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Thu, Apr 29',
        time: '1:00 PM',
        location: 'Conference Center, Brisbane',
      ),
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Fri, Apr 30',
        time: '10:00 AM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Sat, May 1',
        time: '3:30 PM',
        location: 'Conference Center, Brisbane',
      ),
    ];
  }

  void loadConnections() {
    connections.value = [
      Connection(
        id: '1',
        name: 'Alex Lee',
        imagePath: Assets.images.img1.path,
        location: 'Gold Coast, Australia',
      ),
      Connection(
        id: '2',
        name: 'Micheal Wells',
        imagePath: Assets.images.img2.path,
        location: 'Sydney, Australia',
      ),
      Connection(
        id: '3',
        name: 'Chris Mackay',
        imagePath: Assets.images.img3.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '4',
        name: 'Danny Silbia',
        imagePath: Assets.images.img4.path,
        location: 'Gold Coast, Australia',
      ),
      Connection(
        id: '5',
        name: 'Mathew Nicks',
        imagePath: Assets.images.img5.path,
        location: 'Gold Coast, Australia',
      ),
      Connection(
        id: '6',
        name: 'Mark Campbell',
        imagePath: Assets.images.img6.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '7',
        name: 'Tayla Jones',
        imagePath: Assets.images.img7.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '8',
        name: 'John Kelly',
        imagePath: Assets.images.img8.path,
        location: 'Sydney, Australia',
      ),
      Connection(
        id: '9',
        name: 'Zane Williams',
        imagePath: Assets.images.img10.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '10',
        name: 'Danny Silbia',
        imagePath: Assets.images.img4.path,
        location: 'Gold Coast, Australia',
      ),
      Connection(
        id: '11',
        name: 'Mathew Nicks',
        imagePath: Assets.images.img5.path,
        location: 'Gold Coast, Australia',
      ),
      Connection(
        id: '12',
        name: 'Mark Campbell',
        imagePath: Assets.images.img6.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '13',
        name: 'Tayla Jones',
        imagePath: Assets.images.img7.path,
        location: 'Brisbane, Australia',
      ),
      Connection(
        id: '14',
        name: 'John Kelly',
        imagePath: Assets.images.img8.path,
        location: 'Sydney, Australia',
      ),
      Connection(
        id: '15',
        name: 'Zane Williams',
        imagePath: Assets.images.img10.path,
        location: 'Brisbane, Australia',
      ),
    ];
  }
}
