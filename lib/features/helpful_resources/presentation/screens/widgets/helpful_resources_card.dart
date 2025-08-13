import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/helpful_resources/presentation/screens/resources_detail_screen.dart';

class HelpfulResourceCard extends StatelessWidget {
  final String title;
  final String type;
  final String imageUrl;

  const HelpfulResourceCard({
    super.key,
    required this.title,
    required this.type,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ResourcesDetailScreen(type: type));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 16), // 0px 16px
              blurRadius: 32, // 32px
              spreadRadius: 0, // 0px
              color: Color(0xFF493E83).withOpacity(0.12),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                  // topLeft: Radius.circular(16),
                  // bottomLeft: Radius.circular(16),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    if (type.toLowerCase() == 'video')
                      Assets.images.playIcon.image(
                        height: 16,
                        width: 16,
                        // colorFilter: const ColorFilter.mode(
                        //   AppColors.white,
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    // const Icon(
                    //   Icons.play_circle_rounded,
                    //   color: Colors.white70,
                    //   size: 32,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Resource Type - $type',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
