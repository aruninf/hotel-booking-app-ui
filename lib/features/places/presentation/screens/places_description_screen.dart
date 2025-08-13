import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/favourite_events/presentation/controllers/favourite_events_controller.dart';
import 'package:nudge/features/home/presentation/screens/widgets/custom_image_stack.dart';
import 'package:nudge/features/home/presentation/screens/widgets/title_widget.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/connection_card.dart';

class PlaceDescriptionScreen extends StatefulWidget {
  const PlaceDescriptionScreen({super.key});

  @override
  State<PlaceDescriptionScreen> createState() => _PlaceDescriptionScreenState();
}

class _PlaceDescriptionScreenState extends State<PlaceDescriptionScreen> {
  final controller = Get.find<FavouriteEventsController>();
  final profileController = Get.find<ProfileController>();
  final Map<String, ConnectionType> connectionStates = {};
  final ScrollController _scrollController = ScrollController();

  bool isBookmarked = false;
  bool isCheckedIn = false;
  bool _isAtBottom = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  void updateConnectionType(String connectionId, ConnectionType type) {
    setState(() {
      connectionStates[connectionId] = type;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent - 10) {
      if (!_isAtBottom) {
        setState(() => _isAtBottom = true);
      }
    } else {
      if (_isAtBottom) {
        setState(() => _isAtBottom = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    return CustomScaffold(
      child: AppScaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background Image
                      Stack(
                        children: [
                          SizedBox(
                            height: 245,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/park.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 52,
                            left: 18,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 52,
                            right: 18,
                            child: Row(
                              children: [
                                if (isCheckedIn)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                      ),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white30.withOpacity(
                                            0.4,
                                          ),
                                          // semi-transparent for frosted look
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isCheckedIn = !isCheckedIn;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Assets.images.loginWhite.svg(
                                              height: 35,
                                              width: 35,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                HorizontalSpacing(12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: toggleBookmark,
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white30.withOpacity(
                                            0.4,
                                          ),
                                          // semi-transparent for frosted look
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              isBookmarked
                                                  ? Assets
                                                      .images
                                                      .bookmarkSelected
                                                      .svg(
                                                        height: 35,
                                                        width: 35,
                                                        color: AppColors.white,
                                                      )
                                                  : Assets.images.bookmark.svg(
                                                    height: 35,
                                                    width: 35,
                                                    color: AppColors.white,
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Top Info Card
                      Positioned(
                        top: 215,
                        left: 40,
                        right: 24,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              useRootNavigator: true,
                              context: context,
                              builder:
                                  (context) => FractionallySizedBox(
                                    heightFactor:
                                        (MediaQuery.of(context).size.height -
                                            123) /
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
                                          horizontal: 20,
                                        ).copyWith(
                                          bottom: context.devicePaddingBottom,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            VerticalSpacing(12),
                                            Center(
                                              child:
                                                  Assets.images.rectangle.svg(),
                                            ),
                                            VerticalSpacing(12),
                                            Text(
                                              'Checked In',
                                              style: context.text.displaySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.titleColor,
                                                  ),
                                            ),
                                            VerticalSpacing(18),
                                            const SearchTextfield(
                                              title: 'Search',
                                            ),
                                            VerticalSpacing(18),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                    AppRoutes.userProfile,
                                                  );
                                                },
                                                child: Obx(
                                                  () => ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const VerticalSpacing(
                                                              16,
                                                            ),
                                                    itemCount:
                                                        profileController
                                                            .connections
                                                            .length,
                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      final connection =
                                                          profileController
                                                              .connections[index];
                                                      final type =
                                                          connectionStates[connection
                                                              .id] ??
                                                          ConnectionType
                                                              .connect;

                                                      return ConnectionCard(
                                                        connection: connection,
                                                        connectionType: type,
                                                        onConnectionTypeChanged:
                                                            (newType) =>
                                                                updateConnectionType(
                                                                  connection.id,
                                                                  newType,
                                                                ),
                                                        trailing: Obx(() {
                                                          final isRequestSent =
                                                              profileController
                                                                  .isRequestSent(
                                                                    index,
                                                                  );
                                                          return SizedBox(
                                                            width:
                                                                isRequestSent
                                                                    ? 100
                                                                    : 72,
                                                            child: AppOutlinedButton(
                                                              onPressed:
                                                                  () => profileController
                                                                      .toggleRequestSent(
                                                                        index,
                                                                      ),
                                                              text:
                                                                  isRequestSent
                                                                      ? "Request Sent"
                                                                      : "Connect",
                                                              height: 32,
                                                              backgroundColor:
                                                                  isRequestSent
                                                                      ? AppColors
                                                                          .primary800
                                                                      : AppColors
                                                                          .foundationPrimary50,
                                                              textStyle: context
                                                                  .text
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    color:
                                                                        isRequestSent
                                                                            ? AppColors.white
                                                                            : AppColors.foundationPrimary500,
                                                                  ),
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // VerticalSpacing(12),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CustomImageStack(
                                  imageUrls: [
                                    'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
                                    'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                                  ],
                                  itemRadius: 18,
                                  maxDisplayedImages: 3,
                                  itemBorderWidth: 2,
                                  itemBorderColor: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  '+20 Checked In',
                                  style: context.text.labelMedium!.copyWith(
                                    color: AppColors.boldTextColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                if (isCheckedIn)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.greenCheck,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Live Now",
                                      style: context.text.labelSmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryContainerColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Share",
                                      style: context.text.labelSmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Check In Button
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Stack(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              controller: _scrollController,
                              physics:
                                  !isCheckedIn
                                      ? const ClampingScrollPhysics()
                                      : const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hyde Park',
                                        style: context.text.bodyLarge!.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[50],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          'NOT CROWDED',
                                          style: context.text.labelSmall!
                                              .copyWith(
                                                fontSize: 12,
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          _buildTag("Outdoor"),
                                          const SizedBox(width: 5),
                                          _buildTag("Places"),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.images.eventLocation.path,
                                          ),
                                          SizedBox(width: 6),
                                          Column(
                                            children: [
                                              Text(
                                                "36 Dream Lane",
                                                style: context.text.labelMedium!
                                                    .copyWith(
                                                      color:
                                                          AppColors
                                                              .boldTextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              Text(
                                                "Sydney, Australia",
                                                style: context.text.labelMedium!
                                                    .copyWith(
                                                      color:
                                                          AppColors.lightGrey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "Description",
                                        style: context.text.labelMedium!
                                            .copyWith(
                                              color: AppColors.boldTextColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'This is placeholder text only, intended for visual demonstration purposes only. The content here is not meant to convey any specific information but to illustrate how text will appear in the final design. Please note that this text will be replaced with the approved content at the final stage.\n\nFor now, it serves to provide a general idea of layout and formatting. For now, it serves to provide a general idea of layout and formatting. re is not meant to convey any specific information but to illustrate how text will appear in the final design. Please note that this text will be replaced with the approved content at the final stage.\n\nFor now, it serves to provide a general idea of layout and formatting. For now, it serves to provide a general idea of layout and formatting.',
                                        style: context.text.labelSmall!
                                            .copyWith(
                                              color: AppColors.boldTextColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                      ),
                                      !isCheckedIn
                                          ? SizedBox()
                                          : Column(
                                            children: [
                                              const SizedBox(height: 16),
                                              TitleWidget(
                                                leadingtitle:
                                                    'Events At Location',
                                                ontap: () {},
                                              ),
                                              const SizedBox(height: 12),
                                              Container(
                                                height: 106,
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                  bottom: 20,
                                                ),
                                                child: Container(
                                                  color: AppColors.transparent,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        profileController
                                                            .events
                                                            .length,
                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      final event =
                                                          profileController
                                                              .events[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              right: 13.0,
                                                            ),
                                                        child: CommonEventCard(
                                                          event: event,
                                                          width: 326,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      VerticalSpacing(isCheckedIn ? 60 : 130),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        !isCheckedIn
                            ? Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: IgnorePointer(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.white,
                                        AppColors.white,
                                        AppColors.white,
                                        AppColors.bottomScaffoldGradient,
                                        Color(0xB3F2F1F6),
                                        Color(0x8AF2F1F6),
                                        Color(0x6EF2F1F6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              !isCheckedIn
                  ? Positioned(
                    bottom: 20,
                    left: 52,
                    right: 52,
                    child: AppOutlinedButtonWithArrow(
                      width: 271,
                      height: 58,
                      backgroundColor: AppColors.foundation500,
                      textColor: AppColors.white,
                      textStyle: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      text: 'CHECK IN',
                      onPressed: () {
                        setState(() {
                          isCheckedIn = !isCheckedIn;
                        });
                      },
                    ),
                  )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 12))),
    );
  }
}
