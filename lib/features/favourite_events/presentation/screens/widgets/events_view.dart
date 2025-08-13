import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_controller.dart';

class UpcomingEventsView extends StatelessWidget {
  const UpcomingEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavouriteEventsController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ).copyWith(bottom: context.devicePaddingBottom + 28),
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const VerticalSpacing(18),
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            final event = controller.events[index];
            return CommonEventCard(event: event);
          },
        ),
      ),
    );
  }
}

class PastEventsView extends StatelessWidget {
  const PastEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.scheduleDate.image(),
                VerticalSpacing(32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29.0),
                  child: Text(
                    "No Upcoming Events",
                    style: context.text.headlineSmall!.copyWith(
                      fontSize: 24,
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                VerticalSpacing(13),
                Text(
                  'This is placeholder text only, intended for visual demonstration only.',
                  style: context.text.titleMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.lightGrey,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(50),
              ],
            ),
            AppOutlinedButtonWithArrow(
              width: 271,
              height: 58,
              backgroundColor: AppColors.foundation500,
              textColor: AppColors.white,
              textStyle: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
              text: 'EXPLORE MORE',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
