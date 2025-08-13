import 'package:flutter/material.dart';

class CustomImageStack extends StatelessWidget {
  final List<String> imageUrls;
  final double itemRadius;
  final double itemBorderWidth;
  final Color itemBorderColor;
  final int maxDisplayedImages;

  const CustomImageStack({
    super.key,
    required this.imageUrls,
    this.itemRadius = 26,
    this.itemBorderWidth = 2,
    this.itemBorderColor = Colors.white,
    this.maxDisplayedImages = 3,
  });

  @override
  Widget build(BuildContext context) {
    final displayCount =
        imageUrls.length > maxDisplayedImages
            ? maxDisplayedImages
            : imageUrls.length;

    return SizedBox(
      height: itemRadius * 2,
      width:
          displayCount > 0
              ? itemRadius * 2 + (displayCount - 1) * (itemRadius * 0.7)
              : 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left:
                  (displayCount - i - 1) *
                  (itemRadius * 1.3), // 👈 reverse position
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: itemBorderColor,
                    width: itemBorderWidth,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(itemRadius),
                  child: Image.network(
                    imageUrls[i],
                    width: itemRadius * 1.8,
                    height: itemRadius * 1.8,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: itemRadius * 2,
                        height: itemRadius * 2,
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.person,
                          size: itemRadius,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: itemRadius * 2,
                        height: itemRadius * 2,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
