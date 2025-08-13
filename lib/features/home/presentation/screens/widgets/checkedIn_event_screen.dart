import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:nudge/common/custom_style_chip.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/home/presentation/screens/widgets/custom_image_stack.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_bindings.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/connection_card.dart';

class CheckedInEventScreen extends StatefulWidget {
  const CheckedInEventScreen({super.key});

  @override
  State<CheckedInEventScreen> createState() => _CheckedInEventScreenState();
}

class _CheckedInEventScreenState extends State<CheckedInEventScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;
  final controller = Get.find<ProfileController>();

  bool isBookmarked = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  //bool _isRequestSent = false;
  // final Set<int> _sentRequestIndices = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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

  // void _toggle() {
  //   setState(() {
  //     _isRequestSent = !_isRequestSent;
  //   });
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return CustomScaffold(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: Stack(
            children: [
              Column(
                children: [
                  // Top Image + Buttons
                  Stack(
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          Assets.images.eventDetailsImage.path,
                          height: 244,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 18,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 55,
                        right: 23,
                        child: Row(
                          children: [
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
                                    color: Colors.white30.withOpacity(0.4),
                                    // semi-transparent for frosted look
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => Get.back(),
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
                                      color: Colors.white30.withOpacity(0.4),
                                      // semi-transparent for frosted look
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          isBookmarked
                                              ? Assets.images.bookmarkSelected
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

                  // Avatars + Share button
                  Transform.translate(
                    offset: const Offset(0, -30),
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A5A5A5A),
                            blurRadius: 20,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomImageStack(
                                imageUrls: [
                                  'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
                                  'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                                  'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
                                  'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80',
                                ],
                                itemRadius: 18,
                                maxDisplayedImages: 2,
                                itemBorderWidth: 2,
                                itemBorderColor: Colors.white,
                              ),
                              const SizedBox(width: 14),
                              Text(
                                '+20 Checked In',
                                style: context.text.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.foundationBlue500,
                                ),
                              ),
                            ],
                          ),
                          AppOutlinedButton(
                            text: "Live Now",
                            backgroundColor: AppColors.greenCheck,
                            onPressed: () {
                              ProfileInitializer.initialize();
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
                                            horizontal: 33,
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
                                                    Assets.images.rectangle
                                                        .svg(),
                                              ),
                                              VerticalSpacing(12),
                                              Text(
                                                'Checked In',
                                                style: context
                                                    .text
                                                    .displaySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.titleColor,
                                                    ),
                                              ),
                                              VerticalSpacing(18),
                                              const SearchTextfield(
                                                title: 'Search',
                                              ),
                                              VerticalSpacing(18),
                                              Expanded(
                                                child: Obx(
                                                  () => GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppRoutes.userProfile,
                                                      );
                                                    },
                                                    child: ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              const VerticalSpacing(
                                                                16,
                                                              ),
                                                      itemCount:
                                                          controller
                                                              .connections
                                                              .length,
                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        final connection =
                                                            controller
                                                                .connections[index];

                                                        return ConnectionCard(
                                                          connection:
                                                              connection,
                                                          trailing: Obx(() {
                                                            final isRequestSent =
                                                                controller
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
                                                                    () => controller
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
                            textStyle: context.text.bodySmall!.copyWith(
                              color: AppColors.white,
                            ),
                            width: 70,
                            height: 28,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ).copyWith(bottom: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Speed Connections Brisbane",
                                style: context.text.headlineLarge!.copyWith(
                                  fontSize: 32,
                                  color: AppColors.titleColor,
                                ),
                              ),
                              VerticalSpacing(18),
                              Wrap(
                                spacing: 9,
                                children: const [
                                  CustomChip(label: "Events"),
                                  CustomChip(label: "Business"),
                                  CustomChip(label: "Conference"),
                                ],
                              ),
                              VerticalSpacing(18),

                              Row(
                                children: [
                                  Assets.images.eventCalendar.svg(),
                                  HorizontalSpacing(14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "10 February, 2025",
                                        style: context.text.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.titleColor,
                                        ),
                                      ),
                                      VerticalSpacing(8),
                                      Text(
                                        "Tuesday, 4:00PM - 9:00PM",
                                        style: context.text.bodyMedium!
                                            .copyWith(
                                              color: AppColors.lightGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              VerticalSpacing(12),

                              /// Location
                              Row(
                                children: [
                                  Assets.images.eventLocation.svg(),
                                  HorizontalSpacing(14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dream Convention Center",
                                        style: context.text.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.titleColor,
                                        ),
                                      ),
                                      VerticalSpacing(8),
                                      Text(
                                        "36 Dream Lane, Brisbane",
                                        style: context.text.bodyMedium!
                                            .copyWith(
                                              color: AppColors.lightGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              VerticalSpacing(18),

                              /// Description
                              Text(
                                "Description",
                                style: context.text.headlineSmall!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.titleColor,
                                ),
                              ),
                              VerticalSpacing(8),
                              Text(
                                "This is placeholder text only, intended for visual demonstration purposes only. The content here is not meant to convey any specific information but to illustrate how text will appear in the final design. Please note that this text will be replaced with the approved content at the final stage. For now, it serves to provide a general idea of layout and formatting.\n\nThis is placeholder text only, intended for visual demonstration purposes only. For now, it serves to provide a general idea of layout and formatting.",
                                style: context.text.bodyLarge!.copyWith(
                                  color: AppColors.boldTextColor,
                                  height: 1.8,
                                ),
                              ),
                              VerticalSpacing(18),
                              Row(
                                children: [
                                  Assets.images.ticketRequired.svg(),
                                  HorizontalSpacing(14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ticket Required",
                                        style: context.text.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.titleColor,
                                        ),
                                      ),
                                      VerticalSpacing(8),
                                      Text(
                                        "\$90 AUD per person",
                                        style: context.text.bodyMedium!
                                            .copyWith(
                                              fontSize: 13,
                                              color: AppColors.lightGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              VerticalSpacing(31),
                              Center(
                                child: AppOutlinedButton(
                                  borderColor: Color(0x577542C2),
                                  width: 238,
                                  height: 48,
                                  text: "Check Out",
                                  textStyle: context.text.titleLarge!.copyWith(
                                    color: AppColors.foundation500,
                                  ),
                                  backgroundColor: AppColors.foundation50,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Top fading effect
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
