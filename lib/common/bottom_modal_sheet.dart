import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/profile/presentation/controllers/profile_controller.dart';
import 'package:nudge/features/profile/presentation/screens/widgets/connection_card.dart';

Future<void> showCustomConfirmationBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
  required String confirmText,
  required VoidCallback onConfirm,
  String cancelText = 'CANCEL',
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    builder:
        (context) => Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 29,
            ).copyWith(bottom: context.devicePaddingBottom + 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpacing(10),
                Center(child: Assets.images.rectTop.svg()),
                const VerticalSpacing(56),
                Text(
                  title,
                  style: context.text.titleLarge!.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral900,
                  ),
                ),
                const VerticalSpacing(19),
                Text(
                  description,
                  style: context.text.titleLarge!.copyWith(
                    color: AppColors.neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(19),
                AppOutlinedButton(
                  height: 49,
                  text: confirmText,
                  onPressed: () {
                    // Navigator.pop(context);
                    onConfirm();
                  },
                ),
                const VerticalSpacing(19),
                AppOutlinedButton(
                  height: 49,
                  backgroundColor: AppColors.foundationPrimary50,
                  textStyle: context.text.titleLarge!.copyWith(
                    color: AppColors.foundationPrimary500,
                  ),
                  hasShadow: false,
                  text: cancelText,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const VerticalSpacing(16),
              ],
            ),
          ),
        ),
  );
}

Future<bool> showBottomSheetForSent({
  required BuildContext context,
  required String title,
  required String description,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    builder:
        (context) => Container(
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
              horizontal: 29,
            ).copyWith(bottom: 22 + context.devicePaddingBottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpacing(10),
                Center(child: Assets.images.rectTop.svg()),
                const VerticalSpacing(27),
                Assets.images.successMark.svg(width: 56, height: 56),
                const VerticalSpacing(30),
                Text(
                  title,
                  style: context.text.titleLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(12),
                Text(
                  description,
                  style: context.text.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(16),
              ],
            ),
          ),
        ),
  );
  return true;
}

Future<void> showBottomModalStaus({
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback onPost,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
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
                horizontal: 29,
              ).copyWith(bottom: context.devicePaddingBottom + 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(10),
                  Center(child: Assets.images.rectangle.svg()),
                  const VerticalSpacing(19),
                  Text(
                    "Add Status",
                    style: context.text.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleColor,
                    ),
                  ),
                  const VerticalSpacing(19),
                  AppTextFormField(
                    controller: controller,
                    hintStyle: context.text.titleMedium!.copyWith(
                      color: AppColors.neutral600,
                    ),
                    hintText: 'Add status here',
                    maxLines: 4,
                    enableInteractiveSelection: true,
                  ),
                  const VerticalSpacing(19),
                  Center(
                    child: AppOutlinedButton(
                      height: 49,
                      text: 'POST STATUS',
                      onPressed: () {
                        onPost();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const VerticalSpacing(16),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showCustomBottomSheet({
  required BuildContext context,
  required String title,
  Widget? postfixWidget,
}) {
  final controller = Get.find<ProfileController>();
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
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(12),
                  Center(child: Assets.images.rectangle.svg()),
                  VerticalSpacing(12),

                  /// Title row with optional postfix widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: context.text.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                      ),
                      if (postfixWidget != null) postfixWidget,
                    ],
                  ),
                  VerticalSpacing(18),

                  const SearchTextfield(title: 'Search'),
                  VerticalSpacing(18),

                  /// Scrollable list
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder:
                          (context, index) => const VerticalSpacing(16),
                      itemCount: controller.connections.length,
                      itemBuilder: (context, index) {
                        final connection = controller.connections[index];
                        return ConnectionCard(connection: connection);
                      },
                    ),
                  ),
                  VerticalSpacing(12),
                ],
              ),
            ),
          ),
        ),
  );
}
