import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nudge/core/extension/extensions.dart';

class ResourcesDetailScreen extends StatelessWidget {
  const ResourcesDetailScreen({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: AppColors.white,
      ),
    );
    return CustomScaffold(
      child: AppScaffold(
        body: Column(
          children: [
            VerticalSpacing(25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SvgPicture.asset(Assets.images.loginSvg.path),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.login_rounded,
                  //     color: AppColors.primaryContainerColor,
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      type.toLowerCase() == 'video'
                          ? _buildVideoPlayer()
                          : _buildImageContainer(context),
                      const VerticalSpacing(24),
                      Text(
                        'Placeholder Title - This text is intended for visual purposes only.',
                        style: AppTextStyles.textBodyB1.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.boldTextColor,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const VerticalSpacing(12),
                      HtmlWidget(
                        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.',
                        textStyle: AppTextStyles.textBodyB3.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                      ),
                      const VerticalSpacing(24),
                      const BottomSpacing(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return AppVideoPlayer(
      videoUrl: 'assets/images/What_is_Flutter_.mp4',
      showListener: true,
      onProgressUpdate: (v) {
        // setState(() {
        //   _videoCompleteValue = v;
        // });
      },
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/upcoming_event_sample.png',
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
