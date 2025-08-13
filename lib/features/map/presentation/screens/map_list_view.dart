import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/map/presentation/controllers/map_controller.dart';

class MapListView extends StatefulWidget {
  const MapListView({super.key});

  @override
  State<MapListView> createState() => _MapListViewState();
}

class _MapListViewState extends State<MapListView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapController>();

    return Padding(
      padding: EdgeInsets.only(top: 180),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 80 + context.devicePaddingBottom),
        child: Obx(
          () => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const VerticalSpacing(18),
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              final event = controller.events[index];
              return SizedBox(width: 100, child: CommonEventCard(event: event));
            },
          ),
        ),
      ),
    );
  }
}
