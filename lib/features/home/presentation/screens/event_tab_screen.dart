import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
import 'package:nudge/features/home/presentation/screens/widgets/event_card.dart';
import 'package:nudge/features/home/presentation/screens/widgets/title_widget.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';

class EventTabScreen extends StatefulWidget {
  const EventTabScreen({super.key});

  @override
  State<EventTabScreen> createState() => _EventTabScreenState();
}

class _EventTabScreenState extends State<EventTabScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileController = Get.find<ProfileController>();
      profileController.loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TitleWidget(leadingtitle: 'My Events', ontap: () {}),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              // margin: EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  final card = EventCard(
                    image: 'assets/images/upcoming_event_sample.png',
                    title: 'Speed Connections Br..',
                    imageList: [
                      'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
                      'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                      'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
                      'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
                    ],
                    location: '36 Dream Lane, Brisbane',
                    date: '10',
                    month: 'FEB',
                    onTap: () => Get.toNamed(AppRoutes.eventDetails),
                  );
                  return index == 0
                      ? Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: card,
                      )
                      : card;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TitleWidget(
                leadingtitle: 'Events Around You',
                ontap: () {},
              ),
            ),
            Container(
              color: AppColors.transparent,
              margin: EdgeInsets.only(bottom: 20),
              height: 110,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: profileController.events.length,
                itemBuilder: (context, index) {
                  final event = profileController.events[index];
                  final card = CommonEventCard(
                    event: event,
                    width: 329,
                    topSpacing: 4,
                  );
                  return index == 0
                      ? Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                        child: card,
                      )
                      : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: card,
                      );
                },
              ),
            ),
            //SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TitleWidget(
                leadingtitle: 'Recommended For You',
                ontap: () {},
              ),
            ),
            SizedBox(
              height: 110,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: profileController.events.length,
                itemBuilder: (context, index) {
                  final event = profileController.events[index];
                  final card = CommonEventCard(
                    event: event,
                    width: 329,
                    topSpacing: 4,
                  );
                  return index == 0
                      ? Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 13.0),
                        child: card,
                      )
                      : Padding(
                        padding: const EdgeInsets.only(right: 13.0),
                        child: card,
                      );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TitleWidget(
                leadingtitle: 'Upcoming Events',
                ontap: () {
                  FavouriteEventsInitializer.initialize();
                  Get.toNamed(AppRoutes.favoriteEvent);
                },
              ),
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              // margin: EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  final card = EventCard(
                    onTap: () => Get.toNamed(AppRoutes.eventDetails),
                    image: 'assets/images/upcoming_event_sample.png',
                    title: 'Speed Connections Br..',
                    imageList: [
                      'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
                      'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                      'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
                      'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
                    ],
                    location: '36 Dream Lane, Brisbane',
                    date: '10',
                    month: 'FEB',
                  );
                  return index == 0
                      ? Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: card,
                      )
                      : card;
                },
              ),
            ),
            SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}
