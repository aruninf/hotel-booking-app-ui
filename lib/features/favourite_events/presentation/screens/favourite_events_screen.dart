import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/screens/widgets/events_view.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FavouriteEventsScreen extends StatefulWidget {
  const FavouriteEventsScreen({super.key});

  @override
  State<FavouriteEventsScreen> createState() => _FavouriteEventsScreenState();
}

class _FavouriteEventsScreenState extends State<FavouriteEventsScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onToggleSwitch(int? index) {
    if (index == null) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        appBar: CustomAppBar(
          title: 'Favourite Events',
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: Column(
            children: [
              // Search Row
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ).copyWith(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppTextFormFieldWithoutLabel(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        hintText: 'Search an event...',
                        hintStyle: context.text.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Color(0x80616679),
                        ),
                        // decoration: InputDecoration(
                        //   filled: true,
                        //   fillColor: AppColors.white,
                        //   border: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //       color: Color(0xffeeeeee),
                        //       width: 1,
                        //     ),
                        //   ),
                        //   contentPadding: const EdgeInsets.symmetric(
                        //     vertical: 12,
                        //     horizontal: 16,
                        //   ),
                        // ),
                      ),
                    ),
                    HorizontalSpacing(12),
                    GestureDetector(
                      onTap: () {
                        // Search action
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffeeeeee),
                            width: 1,
                          ),
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
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
              ),
              VerticalSpacing(19),

              // Toggle switch with border
              Container(
                padding: EdgeInsets.all(5),
                //width: 295,
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
                  labels: ['Upcoming', 'Past Events'],
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
                  // animate: true,
                  onToggle: _onToggleSwitch,
                ),
              ),
              VerticalSpacing(19),

              // PageView for swipe + toggle
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [UpcomingEventsView(), PastEventsView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
