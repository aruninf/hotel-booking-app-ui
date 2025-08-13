import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/data/model/profile_response.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({super.key, required this.event});

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
    // final event = widget.event;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ).copyWith(left: 9, right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F493E83),
            offset: Offset(0, 16),
            blurRadius: 32,
          ),
        ],
      ),
      margin: const EdgeInsets.all(6),
      child: Row(
        children: [
          // Image on left
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.event.imagePath,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.event.date}•${widget.event.time}',
                          style: context.text.titleMedium!.copyWith(
                            fontSize: 13,
                            color: AppColors.color7641C3,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: toggleBookmark,
                      child:
                          isBookmarked
                              ? Assets.images.bookmarkSelected.svg()
                              : Assets.images.bookmark.svg(),
                    ),
                  ],
                ),
                VerticalSpacing(5),
                Text(
                  widget.event.title,
                  style: context.text.titleLarge!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                VerticalSpacing(12),
                Row(
                  children: [
                    Assets.images.mapPin.svg(),
                    HorizontalSpacing(2),
                    Text(
                      widget.event.location,
                      style: context.text.titleMedium!.copyWith(
                        fontSize: 13,
                        color: AppColors.lightGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
