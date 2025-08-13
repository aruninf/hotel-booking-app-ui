import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 0).copyWith(bottom: 60),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favourite Events",
                  style: context.text.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.favoriteEvent);
                  },
                  child: Text(
                    "View All",
                    style: context.text.titleMedium!.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing(18),
          Obx(
            () => ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const VerticalSpacing(18),
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                final event = controller.events[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 24.0, left: 12),
                  child: CommonEventCard(event: event),
                );
              },
            ),
          ),
          VerticalSpacing(100),
        ],
      ),
    );
  }
}
