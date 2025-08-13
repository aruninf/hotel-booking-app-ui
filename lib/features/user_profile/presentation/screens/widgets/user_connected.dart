import 'dart:io';

import 'package:nudge/common/common_event_card.dart';
import 'package:nudge/common/custom_style_chip.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_controller.dart';
import 'package:nudge/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:nudge/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';

class UserConnectedScreen extends StatefulWidget {
  const UserConnectedScreen({super.key});

  @override
  State<UserConnectedScreen> createState() => _UserConnectedScreenState();
}

class _UserConnectedScreenState extends State<UserConnectedScreen> {
  File? _image;
  final profileController = Get.find<ProfileController>();
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Scaffold(
        // backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 44.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      child:
                          _image != null
                              ? Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                              : Assets.images.userProfile.image(
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Text(
                "Sophie Marks",
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
              VerticalSpacing(8),
              Text(
                '350',
                style: context.text.titleLarge!.copyWith(
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Connections',
                style: context.text.titleMedium!.copyWith(
                  color: AppColors.lightGrey,
                ),
              ),
              VerticalSpacing(19),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppOutlinedButton(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Assets.images.circleTick.svg(
                        height: 24,
                        width: 24,
                      ),
                    ),
                    onPressed: () async {},
                    textStyle: context.text.titleLarge!.copyWith(
                      color: AppColors.white,
                    ),
                    text: "Connected",
                    height: 48,
                    width: 148,
                  ),
                  HorizontalSpacing(19),
                  AppOutlinedButton(
                    backgroundColor: AppColors.foundationPrimary50,
                    textStyle: context.text.titleLarge!.copyWith(
                      color: AppColors.foundationPrimary500,
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Assets.images.messageCircle.svg(
                        height: 24,
                        width: 24,
                      ),
                    ),
                    onPressed: () async {
                      await Get.to(
                        () => ChatConversationScreen(
                          name: 'Sophie Marks',
                          profileImage: Assets.images.userProfile.path,
                          onTap: () {
                            Get.offAll(DashboardScreen(initialIndex: 2));
                          },
                        ),
                      );

                      1; // or the index of the Chat screen
                    },
                    text: "Message",
                    height: 48,
                    width: 128,
                  ),
                ],
              ),
              SizedBox(height: 19),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ).copyWith(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status ",
                        style: context.text.headlineSmall!.copyWith(
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      VerticalSpacing(8),
                      Text(
                        "This is placeholder text only, intended for visual demonstration purposes only. The content here is not meant to convey any specific information.",
                        style: context.text.titleLarge!.copyWith(
                          fontSize: 16,
                          height: 1.5,
                          color: AppColors.titleColor,
                        ),
                      ),
                      VerticalSpacing(19),
                      Text(
                        "Interests",
                        style: context.text.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                      ),
                      VerticalSpacing(19),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          CustomStyledChip(label: "Business"),
                          CustomStyledChip(label: "Design"),
                          CustomStyledChip(label: "Technology"),
                        ],
                      ),
                      VerticalSpacing(19),
                      Text(
                        "Events Attended",
                        style: context.text.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                      ),
                      VerticalSpacing(19),
                      Container(
                        child: Obx(
                          () => ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            separatorBuilder:
                                (context, index) => const VerticalSpacing(18),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: profileController.events.length,
                            itemBuilder: (context, index) {
                              final event = profileController.events[index];
                              return CommonEventCard(event: event);
                            },
                          ),
                        ),
                      ),
                      VerticalSpacing(100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
