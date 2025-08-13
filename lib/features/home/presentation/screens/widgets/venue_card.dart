import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_controller.dart';
import 'package:nudge/features/places/presentation/screens/places_description_screen.dart';

class VenueCard extends StatefulWidget {
  const VenueCard({
    super.key,
    required this.image,
    required this.title,
    this.status,
    required this.location,
  });

  final String image;
  final String title;
  final String? status;
  final String location;

  @override
  State<VenueCard> createState() => _VenueCardState();
}

class _VenueCardState extends State<VenueCard> {
  bool isBookmarked = true;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!Get.isRegistered<FavouriteEventsController>()) {
          FavouriteEventsInitializer.destroy();
          FavouriteEventsInitializer.initialize();
        }
        Get.to(PlaceDescriptionScreen());
      },
      child: Container(
        width: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF505588).withValues(alpha: 0.03),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        margin: const EdgeInsets.only(right: 16, top: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Venue image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.image,
                    width: 82,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12),
              // Venue details
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment:
                      widget.status != null
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status badge
                    if (widget.status != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFECFDF3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.status ?? '',
                          style: context.text.labelMedium!.copyWith(
                            color: Color(0xFF027A48),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    if (widget.status != null) SizedBox(height: 6),
                    // Title
                    Text(
                      widget.title,
                      style: context.text.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.boldTextColor,
                        // height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    // Location
                    Row(
                      children: [
                        Assets.images.mapPin.svg(width: 14, height: 14),
                        // Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          widget.location,
                          style: context.text.labelMedium!.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Bookmark icon
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: toggleBookmark,
                    child:
                        isBookmarked
                            ? Assets.images.bookmarkSelected.svg()
                            : Assets.images.bookmark.svg(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
