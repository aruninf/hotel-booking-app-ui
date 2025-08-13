import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/map/data/source/map_remote_source.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';

class MapController extends GetxController {
  MapController({required this.remoteSource});

  final MapRemoteSource remoteSource;
  RxList<Event> events = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    favoriteEvents();
  }

  void favoriteEvents() {
    events.value = [
      Event(
        title: 'Founder\'s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Wed, Apr 28',
        time: '5:30 PM',
        location: 'Gaven, Gold Coast',
        latitude: -27.9600,
        longitude: 153.3650,
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Thu, Apr 29',
        time: '1:00 PM',
        location: 'Molendinar, Gold Coast',
        latitude: -27.9520,
        longitude: 153.3570,
      ),
      Event(
        title: 'Founder\'s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Friday, Apr 30',
        time: '10:00 AM',
        location: 'Ashmore Road, Gold Coast',
        latitude: -27.9645,
        longitude: 153.3820,
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Saturday, May 1',
        time: '3:30 PM',
        location: 'Benowa Gardens, Gold Coast',
        latitude: -27.9770,
        longitude: 153.3680,
      ),
      Event(
        title: 'Founder\'s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Wed, Apr 28',
        time: '5:30 PM',
        location: 'Parklands, Gold Coast',
        latitude: -27.9485,
        longitude: 153.3745,
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Thu, Apr 29',
        time: '1:00 PM',
        location: 'Ashmore Plaza, Gold Coast',
        latitude: -27.9560,
        longitude: 153.3830,
      ),
      Event(
        title: 'Founder\'s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Friday, Apr 30',
        time: '10:00 AM',
        location: 'Crestwood Heights, Gold Coast',
        latitude: -27.9620,
        longitude: 153.3495,
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Saturday, May 1',
        time: '3:30 PM',
        location: 'Heeb Street, Gold Coast',
        latitude: -27.9705,
        longitude: 153.3600,
      ),
    ];
  }
}
