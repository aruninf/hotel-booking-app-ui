import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_bindings.dart';
import 'package:nudge/features/chat/presentation/screens/chat_screen.dart';
import 'package:nudge/features/home/presentation/controllers/home_bindings.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';
import 'package:nudge/features/home/presentation/screens/home_screen.dart';
import 'package:nudge/features/map/presentation/controllers/map_bindings.dart';
import 'package:nudge/features/map/presentation/screens/map_screen.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_bindings.dart';
import 'package:nudge/features/profile/presentation/screens/profile_screen.dart';
import 'package:nudge/features/search/presentation/controllers/search_bindings.dart';
import 'package:nudge/features/search/presentation/screens/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.initialIndex = 0, this.customPages});

  final int initialIndex;
  final List<Widget>? customPages;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  var _bottomNavIndex = 0;
  bool isScrollingDown = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<int> _navigationStack = [];
  List<String> name = ["Home", "Map", "Chat", "Profile"];
  bool _isShowingDefaultPage = true;
  final GlobalKey<ChatScreenState> chatScreenKey = GlobalKey<ChatScreenState>();

  final List<String> svgIconList = [
    'assets/images/home_icon.svg',
    'assets/images/location.svg',
    'assets/images/Chat.svg',
    'assets/images/profile_icon.svg',
  ];
  final List<String> unColoredImageList = [
    Assets.images.homeUncoloredSvg.path,
    Assets.images.mapUncoloredSvg.path,
    Assets.images.chatUncoloredSvg.path,
    Assets.images.profileUncoloredSvg.path,
  ];
  final List<String> coloredImageList = [
    Assets.images.homeColoredSvg.path,
    Assets.images.mapColouredSvg.path,
    Assets.images.chatColoredSvg.path,
    Assets.images.profileColoredSvg.path,
  ];
  late final List<Widget> _defaultPages = [
    const HomeScreen(),
    const MapScreen(),
    ChatScreen(key: chatScreenKey),
    const ProfileScreen(),
    const SearchScreen(),
  ];

  // Actual pages to display
  late List<Widget> _pages;

  void onItemTapped(int index) {
    Get.find<HomeController>().clearControllers();
    if (chatScreenKey.currentState != null) {
      chatScreenKey.currentState!.closeAllSlidables();
    }
    if (_bottomNavIndex != index) {
      _navigationStack.add(_bottomNavIndex);
      setState(() {
        _bottomNavIndex = index;
        _isShowingDefaultPage = true;
        if (widget.customPages != null) {
          _pages = _defaultPages;
        }
      });
    }
  }

  @override
  void initState() {
    // onItemTapped(widget.selectedIndex);
    _bottomNavIndex = widget.initialIndex;
    _pages = widget.customPages ?? _defaultPages;
    _isShowingDefaultPage = widget.customPages == null;
    super.initState();
    //ProfileInitializer.destroy();
    ProfileInitializer.initialize();
    // MapInitializer.destroy();
    MapInitializer.initialize();
    // SearchInitializer.destroy();
    SearchInitializer.initialize();
    // ChatInitializer.destroy();
    ChatInitializer.initialize();
    HomeInitializer.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    // Set status bar icon color based on selected tab
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness:
            _bottomNavIndex == 0
                ? Brightness
                    .light // Home: light icons
                : Brightness.dark, // Others: dark icons
        systemNavigationBarColor: AppColors.white,
      ),
    );

    return PopScope(
      canPop: _bottomNavIndex == 0,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (_navigationStack.isNotEmpty) {
            setState(() {
              _bottomNavIndex =
                  _navigationStack.removeLast(); // Pop to previous
              _isShowingDefaultPage = true;
              if (widget.customPages != null) {
                _pages = _defaultPages;
              }
            });
          } else if (_bottomNavIndex != 0) {
            setState(() {
              _bottomNavIndex = 0;
              _isShowingDefaultPage = true;
              if (widget.customPages != null) {
                _pages = _defaultPages;
              }
            });
          } else {
            // Close app if stack is empty and on home
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        key: _scaffoldKey,
        extendBody: true,
        //  drawer: DrawerScreen(scaffoldMessengerKey: _scaffoldMessengerKey),
        body: IndexedStack(
          index: _bottomNavIndex >= _pages.length ? 0 : _bottomNavIndex,
          children: _pages,
        ),
        floatingActionButton:
            isKeyboardOpen
                ? null
                : FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isShowingDefaultPage = true;
                      _bottomNavIndex = 4;

                      // If we have custom pages but user tapped search, switch to default pages and show search
                      if (widget.customPages != null) {
                        _pages = _defaultPages;
                      }
                    });
                  },
                  backgroundColor: AppColors.foundation500,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    _bottomNavIndex == 4
                        ? Assets.images.searchZoomOutColored.path
                        : Assets.images.searchZoomOut.path,
                  ),
                ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 70,
          elevation: 1,
          borderWidth: BorderSide.strokeAlignInside,
          itemCount: coloredImageList.length,
          tabBuilder: (int index, bool isActive) {
            // final shouldBeActive =
            //     _isShowingDefaultPage && _bottomNavIndex == index;

            final color =
                isActive ? AppColors.foundation500 : AppColors.neutral600;
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      isActive
                          ? coloredImageList[index]
                          : unColoredImageList[index],
                    ),
                  ),

                  // Icon(iconList[index], size: 22, color: color),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Text(
                          name[index],
                          style: context.text.titleLarge!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: color,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(top: 2),
                          height: 3,
                          width: 6,
                          decoration: BoxDecoration(
                            color:
                                isActive
                                    ? AppColors.foundation500
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          backgroundColor: AppColors.white,
          activeIndex: _isShowingDefaultPage ? _bottomNavIndex : -1,
          splashColor: AppColors.white,

          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.smoothEdge,
          // Smooth curve
          gapLocation: GapLocation.center,
          // Creates space for FAB
          onTap: (index) => onItemTapped(index),
          // hideAnimationController: _hideBottomBarAnimationController,
        ),
      ),
    );
  }
}
