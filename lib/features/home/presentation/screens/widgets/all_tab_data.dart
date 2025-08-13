import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
import 'package:nudge/features/favourite_events/presentation/screens/favourite_events_screen.dart';
import 'package:nudge/features/helpful_resources/presentation/screens/helpful_resources_screen.dart';
import 'package:nudge/features/home/presentation/screens/widgets/event_card.dart';
import 'package:nudge/features/home/presentation/screens/widgets/title_widget.dart';
import 'package:nudge/features/home/presentation/screens/widgets/venue_card.dart';

class AllTabData extends StatelessWidget {
  const AllTabData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (selectedTabIndex == 0 || selectedTabIndex == 1)
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Upcoming Events', ontap: () {}),
        ),
        // SizedBox(height: 4),
        // if (selectedTabIndex == 0 || selectedTabIndex == 1)
        SizedBox(
          // color: Colors.grey.shade100,
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
        // SizedBox(height: 8),
        // if (selectedTabIndex == 0 || selectedTabIndex == 2)
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Trending Venues', ontap: () {}),
        ),

        // if (selectedTabIndex == 0 || selectedTabIndex == 2)
        Container(
          height: 132,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 24),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              final card = VenueCard(
                image: 'assets/images/map.png',
                status: "NOT CROWDED",
                title: "Co-working Space\nName/ Restaurant Name",
                location: "Rainbow Bay, GC, AUS",
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

        // if (selectedTabIndex == 0 || selectedTabIndex == 2)
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(
            leadingtitle: 'Popular Outdoor Places',
            ontap: () {},
          ),
        ),

        // if (selectedTabIndex == 0 || selectedTabIndex == 2)
        Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 24),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              final card = VenueCard(
                image: 'assets/images/map.png',
                title: "Hyde Park",
                location: "Rainbow Bay, GC, AUS",
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

        // if (selectedTabIndex == 0 || selectedTabIndex == 1)
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(
            leadingtitle: 'Favourite Events',
            ontap: () {
              FavouriteEventsInitializer.initialize();
              Get.to(FavouriteEventsScreen());
            },
          ),
        ),

        // if (selectedTabIndex == 0 || selectedTabIndex == 1)
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

        // if (selectedTabIndex == 0)
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(
            leadingtitle: 'Helpful Resources',
            ontap: () {
              Get.to(const HelpfulResourcesScreen(showBottomNav: true));
            },
          ),
        ),

        // if (selectedTabIndex == 0)
        Container(
          height: 295,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 24),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              final card = GestureDetector(
                onTap: () => Get.to(HelpfulResourcesScreen()),
                child: ResourceCard(),
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
    );
  }
}
