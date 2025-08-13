import 'dart:ui';

import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/presentation/screens/widgets/custom_image_stack.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.imageList,
    required this.date,
    required this.month,
    this.onTap,
  });

  final String image;
  final String title;
  final String location;
  final List<String> imageList;
  final String date;
  final String month;
  final VoidCallback? onTap;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isBookmarked = true;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Get.toNamed(AppRoutes.eventDetails),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF505588).withValues(alpha: 0.06),
              offset: const Offset(0, 8),
              blurRadius: 30,
            ),
          ],
        ),

        // elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image with date and bookmark
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: 12.0,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                      // topLeft: Radius.circular(20),
                      // topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      widget.image,
                      height: 131,
                      width: 245,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Date badge
                Positioned(
                  top: 22,
                  left: 23,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // match the Container's borderRadius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.7,
                          ), // semi-transparent
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.date,
                              style: context.text.labelLarge!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.primaryContainerColor,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              widget.month,
                              style: context.text.labelLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: AppColors.primaryContainerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bookmark icon
                Positioned(
                  top: 22,
                  right: 23,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.7,
                          ), // semi-transparent for blur
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: GestureDetector(
                          onTap: toggleBookmark,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                isBookmarked
                                    ? Assets.images.bookmarkSelected.svg(
                                      height: 35,
                                      width: 35,
                                    )
                                    : Assets.images.bookmark.svg(
                                      height: 35,
                                      width: 35,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Event title and attendees
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    style: context.text.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CustomImageStack(
                        imageUrls: widget.imageList,
                        itemRadius: 18,
                        maxDisplayedImages: 3,
                        itemBorderWidth: 2,
                        itemBorderColor: Colors.white,
                      ),
                      const SizedBox(width: 35),
                      Text(
                        '+20 Going',
                        style: context.text.labelMedium!.copyWith(
                          color: Color(0xFF3F38DD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Assets.images.mapPin.svg(width: 14, height: 14),
                      SizedBox(width: 4),
                      Text(
                        widget.location,
                        style: context.text.labelMedium!.copyWith(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  const ResourceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/upcoming_event_sample.png',
                height: 160,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Networking 101',
                style: context.text.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This is placeholder text only, intended for visual demonstration purposes only...',
                style: context.text.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.neutral600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
