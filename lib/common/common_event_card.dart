import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';

class CommonEventCard extends StatefulWidget {
  final Event event;
  final double? width;
  final double? topSpacing;

  const CommonEventCard({
    super.key,
    required this.event,
    this.topSpacing,
    this.width,
  });

  @override
  State<CommonEventCard> createState() => _CommonEventCardState();
}

class _CommonEventCardState extends State<CommonEventCard> {
  bool isBookmarked = true;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    Widget cardContent = GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.eventDetails);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ).copyWith(left: 9, right: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x1F493E83).withOpacity(.01237),
              offset: Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        child: Row(
          children: [
            // Image on left
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                event.imagePath,
                height: 92,
                width: 79,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Text on right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(widget.topSpacing ?? 0.0),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              event.date,
                              style: context.text.titleMedium!.copyWith(
                                fontSize: 13,
                                color: AppColors.color7641C3,
                              ),
                            ),
                            const HorizontalSpacing(4),
                            const Icon(
                              Icons.circle,
                              size: 4,
                              color: AppColors.color7641C3,
                            ),
                            const HorizontalSpacing(4),
                            Flexible(
                              child: Text(
                                event.time,
                                style: context.text.titleMedium!.copyWith(
                                  fontSize: 13,
                                  color: AppColors.color7641C3,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: toggleBookmark,
                          child:
                              isBookmarked
                                  ? Assets.images.bookmarkSelected.svg()
                                  : Assets.images.bookmark.svg(),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacing(5),
                  Text(
                    event.title,
                    style: context.text.titleLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const VerticalSpacing(11),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.images.mapPin.svg(),
                      const HorizontalSpacing(6),
                      Expanded(
                        child: Text(
                          event.location,
                          style: context.text.titleMedium!.copyWith(
                            fontSize: 13,
                            color: AppColors.lightGrey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    return widget.width != null
        ? SizedBox(width: widget.width, child: cardContent)
        : cardContent;
  }
}
