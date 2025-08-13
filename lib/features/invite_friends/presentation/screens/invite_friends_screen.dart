import 'package:nudge/common/bottom_modal_sheet.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/invite_friends/presentation/controllers/invite_friends_controller.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final controller = Get.find<InviteFriendsController>();

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      backgroundColor: AppColors.white,
      bottomLogo: true,
      child: AppScaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: 'Invite Friends',
          onTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ).copyWith(bottom: 24),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Link',
                        style: context.text.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral900,
                        ),
                      ),
                      VerticalSpacing(22),
                      AppTextFormField(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                        ).copyWith(left: 16),
                        controller: controller.linkController,
                        hintText: 'Link',
                        style: context.text.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: AppColors.neutral600,
                        ),
                        textInputType: TextInputType.name,
                        suffixIcon: Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.isCopied.value = true;

                              Future.delayed(const Duration(seconds: 2), () {
                                controller.isCopied.value = false;
                              });
                            },
                            child:
                                controller.isCopied.value
                                    ? Padding(
                                      padding: const EdgeInsets.only(
                                        right: 12.0,
                                      ),
                                      child: Assets.images.tickCircle.svg(),
                                    )
                                    : Padding(
                                      padding: const EdgeInsets.only(
                                        right: 12.0,
                                      ),
                                      child: Assets.images.copyIcon.svg(),
                                    ),
                          ),
                        ),
                      ),
                      const VerticalSpacing(22),
                      Divider(thickness: 1, color: AppColors.neutral300),
                      const VerticalSpacing(22),
                      Text(
                        'Send an invitation',
                        style: context.text.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral900,
                        ),
                      ),
                      const VerticalSpacing(22),
                      Text('Enter email to send an invitation to Nudge'),
                      const VerticalSpacing(22),
                      AppTextFormField(
                        textInputType: TextInputType.emailAddress,
                        labelText: 'Email',
                        style: context.text.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: AppColors.neutral600,
                        ),
                      ),
                      const VerticalSpacing(22),
                    ],
                  ),
                ),
              ),
              AppOutlinedButton(
                text: 'SEND INVITE',
                onPressed: () async {
                  final shouldGoBack = await showBottomSheetForSent(
                    context: context,
                    title: 'Invitation Sent!',
                    description: 'Invitation sent successfully.',
                  );

                  if (shouldGoBack) {
                    Navigator.pop(context);
                  }
                },
              ),
              if (MediaQuery.of(context).size.height < 700)
                const VerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
