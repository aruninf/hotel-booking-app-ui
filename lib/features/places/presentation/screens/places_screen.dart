import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/presentation/screens/widgets/title_widget.dart';
import 'package:nudge/features/home/presentation/screens/widgets/venue_card.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Trending Now', ontap: () {}),
        ),
        Container(
          height: 132,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              final card = VenueCard(
                image: 'assets/images/map.png',
                status: "NOT CROWDED",
                title: "Co-working Space Name/ Restaurant Name",
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
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(
            leadingtitle: 'Popular Outdoor Places',
            ontap: () {},
          ),
        ),
        Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
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
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Venues Around You', ontap: () {}),
        ),
        Container(
          height: 132,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
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
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Parks', ontap: () {}),
        ),
        Container(
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
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
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TitleWidget(leadingtitle: 'Cultural Spots', ontap: () {}),
        ),
        Container(
          height: 132,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
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
        SizedBox(height: 140),
      ],
    );
  }
}
