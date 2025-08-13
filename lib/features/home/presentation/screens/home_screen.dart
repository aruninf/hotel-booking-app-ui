import 'package:flutter/services.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/connect_request/presentation/screens/connect_request_screen.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';
import 'package:nudge/features/home/presentation/screens/event_tab_screen.dart';
import 'package:nudge/features/home/presentation/screens/filter_Screen.dart';
import 'package:nudge/features/home/presentation/screens/widgets/all_tab_data.dart';
import 'package:nudge/features/home/presentation/screens/widgets/tab_button.dart';
import 'package:nudge/features/places/presentation/screens/places_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    FavouriteEventsInitializer.destroy();
    FavouriteEventsInitializer.initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.transparent,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: AppScaffold(
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 24,
                    top: 29,
                    bottom: 33,
                    right: 24,
                  ).copyWith(top: context.devicePaddingTop),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Current Location',
                                          style: context.text.bodySmall
                                              ?.copyWith(
                                                color: AppColors.textColor300,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.textColor300,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Gold Coast, AUS',
                                      style: context.text.labelLarge?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(ConnectRequestScreen());
                                    },
                                    child: Center(
                                      child: Assets.images.notification.svg(
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 7,
                                    top: 7,
                                    child: Container(
                                      width: 11,
                                      height: 11,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF12B76A),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xFF0A653A),
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: AppColors.lightGrey2,
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ).copyWith(left: 0),
                                  child: Assets.images.search.svg(
                                    colorFilter: ColorFilter.mode(
                                      AppColors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                hintText: 'Search...',
                                hintStyle: context.text.labelMedium!.copyWith(
                                  fontSize: 18,
                                  color: AppColors.textColor200,
                                  fontWeight: FontWeight.w400,
                                ),
                                fillColor: Colors.transparent,
                                filled: true,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const FilterScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Container(
                                width: 80,
                                height: 36,
                                decoration: BoxDecoration(
                                  // color: Colors.white10,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.images.filter.svg(
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primary200,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Filters',
                                        style: context.text.bodySmall?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -15,
                  left: 26,
                  child: TabButton(
                    ontap: () {},
                    onTabSelected: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(color: Colors.transparent, height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    if (selectedTabIndex == 0)
                      Container(
                        width: 220,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.greenCheck,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              'Checked In - View Event',
                              style: context.text.bodySmall?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    if (selectedTabIndex == 0) SizedBox(height: 20),
                    if (selectedTabIndex == 0) AllTabData(),
                    if (selectedTabIndex == 1) EventTabScreen(),
                    if (selectedTabIndex == 2) PlacesScreen(),
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
