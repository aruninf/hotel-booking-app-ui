// import 'package:nudge/core/extension/extensions.dart';
// import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
// import 'package:nudge/features/helpful_resources/presentation/screens/helpful_resources_screen.dart';
// import 'package:nudge/features/home/presentation/screens/widgets/event_card.dart';
// import 'package:nudge/features/home/presentation/screens/widgets/title_widget.dart';
// import 'package:nudge/features/home/presentation/screens/widgets/venue_card.dart';

// class AllTabScreen extends StatelessWidget {
//   const AllTabScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 220,
//           height: 32,
//           decoration: BoxDecoration(
//             color: AppColors.greenCheck,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: Text(
//               'Checked In - View Event',
//               style: context.text.bodySmall?.copyWith(
//                 color: AppColors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.only(left: 22.0),
//           child: Column(
//             children: [
//               TitleWidget(leadingtitle: 'Upcoming Events', ontap: () {}),
//               SizedBox(
//                 height: 280,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return EventCard(
//                       image: 'assets/images/upcoming_event_sample.png',
//                       title: 'Speed Connections Br..',
//                       imageList: [
//                         'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
//                         'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
//                         'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
//                         'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
//                       ],
//                       location: '36 Dream Lane, Brisbane',
//                       date: '10',
//                       month: 'FEB',
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               TitleWidget(leadingtitle: 'Trending Venues', ontap: () {}),
//               SizedBox(
//                 height: 130,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return VenueCard(
//                       image: 'assets/images/map.png',
//                       status: "NOT CROWDED",
//                       title: "Co-working Space\nName/ Restaurant Name",
//                       location: "Rainbow Bay, GC, AUS",
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               TitleWidget(
//                 leadingtitle: 'Popular Outdoor Places',
//                 ontap: () {},
//               ),
//               SizedBox(
//                 height: 100,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return OutdoorPlaceCard(
//                       image: 'assets/images/map.png',
//                       title: "Hyde Park",
//                       location: "Rainbow Bay, GC, AUS",
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               TitleWidget(
//                   leadingtitle: 'Favourite Events',
//                   ontap: () {
//                     FavouriteEventsInitializer.initialize();
//                     Get.toNamed(AppRoutes.favoriteEvent);
//                   }),
//               SizedBox(
//                 height: 300,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return EventCard(
//                       image: 'assets/images/upcoming_event_sample.png',
//                       title: 'Speed Connections Br..',
//                       imageList: [
//                         'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
//                         'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
//                         'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
//                         'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
//                       ],
//                       location: '36 Dream Lane, Brisbane',
//                       date: '10',
//                       month: 'FEB',
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 10),
//               TitleWidget(
//                   leadingtitle: 'Helpful Resources',
//                   ontap: () {
//                     Get.to(const HelpfulResourcesScreen());
//                   }),
//               SizedBox(
//                 height: 300,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return ResourceCard();
//                   },
//                 ),
//               ),
//               SizedBox(height: 60),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
