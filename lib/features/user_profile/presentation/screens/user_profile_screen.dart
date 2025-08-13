import 'dart:io';

import 'package:nudge/common/bottom_modal_sheet.dart';
import 'package:nudge/common/custom_style_chip.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/user_profile/presentation/screens/widgets/user_connected.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _image;
  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ).copyWith(top: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
              if (!isPrivate) ...[
                Text(
                  "Gold Coast, AUS",
                  style: context.text.titleMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subTitle,
                  ),
                ),
                VerticalSpacing(19),
                AppOutlinedButton(
                  leading: Assets.images.profileAdd.svg(height: 24, width: 24),
                  onPressed: () async {
                    await showBottomSheetForSent(
                      context: context,
                      title: 'Connection Request Sent',
                      description:
                          'Connection request sent. You’ll be notified when they respond.',
                    );

                    if (mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const UserConnectedScreen(),
                        ),
                      );
                    }
                  },
                  text: "Connect",
                  height: 48,
                  width: 128,
                ),
                SizedBox(height: 19),
                Column(
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
                  ],
                ),
              ] else ...[
                Column(
                  children: [
                    AppOutlinedButton(
                      leading: Assets.images.profileAdd.svg(
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () {},
                      text: "Connect",
                      backgroundColor: AppColors.foundationPrimary500,
                      height: 48,
                      width: 128,
                    ),
                    VerticalSpacing(19),
                    Text(
                      "This account is private. You’ll need to send a connection request to view their profile and activity.",
                      textAlign: TextAlign.center,
                      style: context.text.titleLarge!.copyWith(
                        height: 1.5,
                        fontSize: 16,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [],
        //   currentIndex: 1,
        // ),
      ),
    );
  }
}
