import 'package:flutter/services.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/screens/chat_screen.dart';
import 'package:nudge/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nudge/features/helpful_resources/presentation/screens/widgets/helpful_resources_card.dart';
import 'package:nudge/features/map/presentation/screens/map_screen.dart';
import 'package:nudge/features/profile/presentation/screens/profile_screen.dart';
import 'package:nudge/features/search/presentation/screens/search_screen.dart';

class HelpfulResourcesScreen extends StatelessWidget {
  const HelpfulResourcesScreen({super.key, this.showBottomNav});

  final bool? showBottomNav;

  @override
  Widget build(BuildContext context) {
    // final slidableController = Get.find<ChatController>().slidableController;
    TextEditingController searchController = TextEditingController();
    final List<Map<String, String>> resources = [
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Article',
        'image':
            'https://media.istockphoto.com/id/487764186/photo/never-ending-peace-and-love.jpg?s=612x612&w=0&k=20&c=nBau5nlbXTk11ln_0csVYS-FUavFEE0QmoAjvzZu5co=',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Video',
        'image':
            'https://www.shutterstock.com/shutterstock/videos/1020190420/thumb/1.jpg',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Article',
        'image':
            'https://media.istockphoto.com/id/487764186/photo/never-ending-peace-and-love.jpg?s=612x612&w=0&k=20&c=nBau5nlbXTk11ln_0csVYS-FUavFEE0QmoAjvzZu5co=',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Video',
        'image':
            'https://www.shutterstock.com/shutterstock/videos/1020190420/thumb/1.jpg',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Article',
        'image':
            'https://media.istockphoto.com/id/487764186/photo/never-ending-peace-and-love.jpg?s=612x612&w=0&k=20&c=nBau5nlbXTk11ln_0csVYS-FUavFEE0QmoAjvzZu5co=',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Article',
        'image':
            'https://media.istockphoto.com/id/487764186/photo/never-ending-peace-and-love.jpg?s=612x612&w=0&k=20&c=nBau5nlbXTk11ln_0csVYS-FUavFEE0QmoAjvzZu5co=',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Video',
        'image':
            'https://www.shutterstock.com/shutterstock/videos/1020190420/thumb/1.jpg',
      },
      {
        'title': 'Placeholder Title - visual demonstration purposes..',
        'type': 'Video',
        'image':
            'https://www.shutterstock.com/shutterstock/videos/1020190420/thumb/1.jpg',
      },
    ];
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    Widget content = CustomScaffold(
      child: AppScaffold(
        backgroundColor: AppColors.transparent,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: 'Helpful Resources',
          textStyle: context.text.labelLarge!.copyWith(
            fontSize: 20,
            color: AppColors.boldTextColor,
            fontWeight: FontWeight.w500,
          ),
          onTap: () => Navigator.pop(context),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF505588).withOpacity(0.06),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: AppTextFormField(
                    hintText: 'Search...',

                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      //child: Assets.images.search.svg(),
                    ),
                    controller: searchController,
                    onChanged: (v) {},
                    suffixIcon:
                        searchController.value.text.isNotEmpty
                            ? GestureDetector(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Icon(Icons.clear),
                              ),
                            )
                            : null,
                    fillColor: AppColors.white,
                    // borderSide: const BorderSide(
                    //   color: AppColors.color132534,
                    // ),
                    // enabledBorderSide: const BorderSide(
                    //   color: AppColors.color132534,
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: resources.length,
                  //separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = resources[index];
                    return HelpfulResourceCard(
                      title: item['title']!,
                      type: item['type']!,
                      imageUrl: item['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (showBottomNav ?? false) {
      return DashboardScreen(
        initialIndex: 0, // You can set this to any default tab index
        customPages: [
          content,
          const MapScreen(),
          ChatScreen(),
          const ProfileScreen(),
          const SearchScreen(),
        ],
      );
    } else {
      return content;
    }
  }
}
