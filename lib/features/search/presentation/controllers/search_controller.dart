import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';
import 'package:nudge/features/search/data/source/search_remote_source.dart';

class SearchController extends GetxController {
  SearchController({required this.remoteSource});

  final SearchRemoteSource remoteSource;

  RxList<Event> events = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    favoriteEvents();
  }

  void favoriteEvents() {
    // Example: loading dummy events. You can replace this with an API call later.
    events.value = [
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Wed ,Apr 28',
        time: '5:30 PM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Thu ,Apr 29',
        time: '1:00 PM',
        location: 'Conference Center,  Brisbane',
      ),
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Friday ,Apr 30',
        time: '10:00 AM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Saturday ,May 1',
        time: '3:30 PM',
        location: 'Conference Center,  Brisbane',
      ),
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Wed ,Apr 28',
        time: '5:30 PM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Thu ,Apr 29',
        time: '1:00 PM',
        location: 'Conference Center,  Brisbane',
      ),
      Event(
        title: 'Founder’s Meetup: Connect with Entrepreneurs',
        imagePath: Assets.images.event1.path,
        date: 'Friday ,Apr 30',
        time: '10:00 AM',
        location: 'Rainbow Bay, GC, AUS',
      ),
      Event(
        title: 'Marketing Strategies Workshop',
        imagePath: Assets.images.event2.path,
        date: 'Saturday ,May 1',
        time: '3:30 PM',
        location: 'Conference Center,  Brisbane',
      ),
    ];
  }
}
