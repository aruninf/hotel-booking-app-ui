import 'dart:io';

import 'package:flutter/services.dart';
import 'package:nudge/common/bottom_modal_sheet.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/about_tab_view.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/connection_card.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/event_tab_view.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/settings_tab_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  File? _image;
  late TabController _tabController;
  final controller = Get.find<ProfileController>();
  String? _status;
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: AppColors.appRed,
  //   statusBarIconBrightness: Brightness.dark,
  //   systemNavigationBarColor: AppColors.white,
  // ));
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     systemNavigationBarColor: AppColors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarColor: AppColors.transparent,
    //     statusBarIconBrightness: Brightness.light));
    return CustomScaffold(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        //backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(top: context.devicePaddingTop),
          child: Column(
            children: [
              _buildProfileHeader(),
              VerticalSpacing(12),
              _buildTabBarWithDivider(),
              VerticalSpacing(12),
              Expanded(child: _buildTabViews()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0).copyWith(top: 20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                //borderRadius: BorderRadius.circular(30),
                child:
                    _image != null
                        ? Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : Assets.images.profilePicture.image(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            "Mary Williams",
            style: context.text.displaySmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.titleColor,
              //fontFamily: FontFamily.inter,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Gold Coast, AUS",
            style: context.text.titleMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.subTitle,
            ),
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    context: context,
                    builder:
                        (context) => FractionallySizedBox(
                          heightFactor:
                              (MediaQuery.of(context).size.height - 123) /
                              MediaQuery.of(context).size.height,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(38),
                                topRight: Radius.circular(38),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 33,
                              ).copyWith(bottom: context.devicePaddingBottom),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalSpacing(12),
                                  Center(child: Assets.images.rectangle.svg()),
                                  VerticalSpacing(12),
                                  Text(
                                    'Connections',
                                    style: context.text.displaySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.titleColor,
                                    ),
                                  ),
                                  VerticalSpacing(18),
                                  const SearchTextfield(title: 'Search'),
                                  VerticalSpacing(18),
                                  Expanded(
                                    child: Obx(
                                      () => ListView.separated(
                                        padding: EdgeInsets.zero,
                                        separatorBuilder:
                                            (context, index) =>
                                                const VerticalSpacing(16),
                                        itemCount:
                                            controller.connections.length,
                                        itemBuilder: (context, index) {
                                          final connection =
                                              controller.connections[index];
                                          return ConnectionCard(
                                            connection: connection,
                                            trailing: SizedBox(
                                              width: 70,
                                              child: AppOutlinedButton(
                                                text: "Remove",
                                                textStyle: context
                                                    .text
                                                    .titleSmall!
                                                    .copyWith(
                                                      color:
                                                          AppColors
                                                              .foundationPrimary500,
                                                    ),
                                                height: 32,
                                                backgroundColor:
                                                    AppColors
                                                        .foundationPrimary50,
                                              ),
                                            ),
                                          );
                                        },
                                        // child: ListView.separated(
                                        //   padding: EdgeInsets.zero,
                                        //   separatorBuilder: (context, index) =>
                                        //       const VerticalSpacing(16),
                                        //   itemCount: controller.connections.length,
                                        //   itemBuilder: (context, index) {
                                        //     final connection =
                                        //         controller.connections[index];
                                        //     return ConnectionCard(
                                        //       connection: connection,
                                        //     );
                                        //   },
                                      ),
                                    ),
                                  ),
                                  VerticalSpacing(12),
                                ],
                              ),
                            ),
                          ),
                        ),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      '350',
                      style: context.text.titleLarge!.copyWith(
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Connections',
                      style: context.text.titleMedium!.copyWith(
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ],
                ),
              ),
              HorizontalSpacing(16),
              LineDivider(),
              HorizontalSpacing(16),
              Column(
                children: [
                  Text(
                    '346',
                    style: context.text.titleLarge!.copyWith(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Check-Ins',
                    style: context.text.titleMedium!.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          VerticalSpacing(18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status ",
                style: context.text.headlineSmall!.copyWith(
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (_status != null && _status!.isNotEmpty)
                TextButton(
                  onPressed: () {
                    if (_status == null || _status!.isEmpty) {
                      return; // Do nothing if empty
                    }
                    _statusController.text = _status!;
                    showBottomModalStaus(
                      context: context,
                      controller: _statusController,
                      onPost: () {
                        setState(() {
                          _status = _statusController.text.trim();
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.foundationPrimary50,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Change",
                      style: context.text.titleSmall!.copyWith(
                        color: AppColors.foundationPrimary500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          VerticalSpacing(8),
          if (_status == null || _status!.isEmpty)
            Column(
              children: [
                Text(
                  "No Status Added",
                  style: context.text.titleMedium!.copyWith(
                    color: AppColors.subTitle,
                  ),
                ),
                VerticalSpacing(16),
                ElevatedButton(
                  onPressed: () {
                    _statusController.clear();
                    showBottomModalStaus(
                      context: context,
                      controller: _statusController,
                      onPost: () {
                        setState(() {
                          _status = _statusController.text.trim();
                        });
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.foundationPrimary500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    "Add Status",
                    style: context.text.titleLarge!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _status!,
                style: context.text.titleLarge!.copyWith(
                  color: AppColors.titleColor,
                ),
              ),
            ),
          VerticalSpacing(22),
          Divider(
            color: AppColors.foundationBlue100,
            thickness: 0.7,
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarWithDivider() {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          padding: EdgeInsets.zero,
          indicatorWeight: 3.0,
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 3.0,
              color: AppColors.foundationPrimary500,
            ),
            insets: EdgeInsets.zero,
          ),
          labelColor: AppColors.foundationPrimary500,
          labelStyle: context.text.headlineSmall!.copyWith(
            fontSize: 15,
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w500,
          ),
          labelPadding: EdgeInsets.zero,
          unselectedLabelStyle: context.text.headlineSmall!.copyWith(
            color: AppColors.lightGrey,
            fontSize: 15,
          ),
          indicatorPadding: EdgeInsets.only(bottom: 8),
          dividerColor: AppColors.transparent,
          unselectedLabelColor: AppColors.lightGrey,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: "ABOUT"),
            Tab(text: "YOUR EVENTS"),
            Tab(text: "SETTINGS"),
          ],
        ),
      ],
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: _tabController,
      children: [AboutTab(), EventsTab(), SettingsTab()],
    );
  }
}
