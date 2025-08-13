import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';
import 'package:nudge/features/map/data/source/map_remote_source.dart';
import 'package:nudge/features/map/presentation/controllers/map_controller.dart';
import 'package:nudge/features/map/presentation/screens/map_list_view.dart';
import 'package:nudge/features/map/presentation/screens/widget/map.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver {
  final controller = Get.put(
    MapController(remoteSource: Get.find<MapRemoteSource>()),
  );
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  bool _keyboardVisible = false;

  final _scrollController = ScrollController();

  void _onToggleSwitch(int? index) {
    if (index == null) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isVisible = bottomInset > 0;
    if (_keyboardVisible != isVisible) {
      setState(() {
        _keyboardVisible = isVisible;
      });
    }
  }

  void _scrollToIndex(int index) {
    final scrollPos = index * 339.0; // 327 width + 12 spacing
    _scrollController.animateTo(
      scrollPos,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: AppColors.transparent,
    // ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.white, AppColors.bottomScaffoldGradient],
            ),
          ),
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: Stack(
              children: [
                Positioned.fill(
                  child:
                      _currentIndex == 0
                          ? MapWidget(
                            onMapTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            events: controller.events,
                            onMarkerTap: (index) {
                              _scrollToIndex(index);
                            },
                          )
                          : const MapListView(),
                ),

                // Top bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ).copyWith(top: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppTextFormFieldWithoutLabel(
                                  controller:
                                      homeController.mapSearchController,
                                  hintText: 'Search an event...',
                                  hintStyle: context.text.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    color: const Color(0x80616679),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                        color: Color(0xffeeeeee),
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                  ),
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      if (_currentIndex == 1) {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _currentIndex = 0;
                                        });
                                        _pageController.animateToPage(
                                          0,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      Assets.images.backArrow.path,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  // Search filter action
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffeeeeee),
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x80D3D1D8),
                                        offset: Offset(0, 40),
                                        blurRadius: 60,
                                      ),
                                    ],
                                  ),
                                  child: Assets.images.filterBar.svg(
                                    height: 21,
                                    width: 21,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 19),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.colorE9E8EB,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ToggleSwitch(
                              minWidth: 145.0,
                              minHeight: 35,
                              cornerRadius: 30.0,
                              activeBgColors: const [
                                [Colors.white],
                                [Colors.white],
                              ],
                              activeFgColor: Colors.purple,
                              inactiveBgColor: Colors.transparent,
                              inactiveFgColor: Colors.grey.shade700,
                              initialLabelIndex: _currentIndex,
                              totalSwitches: 2,
                              labels: ['Map View', 'List View'],
                              customTextStyles: [
                                context.text.titleMedium!.copyWith(
                                  fontSize: 15,
                                  color:
                                      _currentIndex == 0
                                          ? AppColors.primary500
                                          : AppColors.foundationBlue300,
                                ),
                                context.text.titleMedium!.copyWith(
                                  fontSize: 15,
                                  color:
                                      _currentIndex == 1
                                          ? AppColors.primary500
                                          : AppColors.foundationBlue300,
                                ),
                              ],
                              radiusStyle: true,
                              onToggle: _onToggleSwitch,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom card list
                if (_currentIndex == 0 && !_keyboardVisible)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 115,
                    height: 170,
                    child: Obx(() {
                      return ListView.separated(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: controller.events.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final event = controller.events[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 48.0),
                            child: Container(
                              width: 327,
                              color: Colors.transparent,
                              child: CommonEventCard(
                                event: event,
                                topSpacing: 15,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
