import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nudge/common/bottom_modal_sheet.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_controller.dart';

class ChatListItem extends StatefulWidget {
  final ChatItem chat;
  final SlidableController slidableController;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.slidableController,
  });

  @override
  State<ChatListItem> createState() => ChatListItemState();
}

class ChatListItemState extends State<ChatListItem> {
  OverlayEntry? overlayEntry;

  void showOverlay(BuildContext context, Offset offset, Size size) {
    final screenSize = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const verticalMargin = 10.0;
    const overlayWidth = 210.0;

    final overlayKey = GlobalKey();

    // Remove existing overlay if any
    removeOverlay();

    // Insert a temporary overlay to measure its height
    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: removeOverlay,
          child: Stack(
            children: [
              Positioned(
                left: (offset.dx - 66).clamp(
                  verticalMargin,
                  screenSize.width - overlayWidth - verticalMargin,
                ),
                top: offset.dy + size.height,
                width: overlayWidth,
                child: Material(
                  key: overlayKey,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: _buildOverlayContent(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          overlayKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final overlayHeight = renderBox.size.height;

      final spaceBelow =
          screenSize.height - (offset.dy + size.height) - bottomInset;
      final spaceAbove = offset.dy - statusBarHeight;

      double topPosition;
      const bottomBuffer = 20.0;
      final maxTopPosition =
          screenSize.height -
          overlayHeight -
          bottomInset -
          verticalMargin -
          bottomBuffer;
      final minTopPosition = statusBarHeight + verticalMargin;

      // If space below is enough and gap between item bottom and overlay top is >= 10, show below
      // Else if space above is enough, show above
      // Else clamp to available space
      if (spaceBelow >= overlayHeight + verticalMargin &&
          spaceBelow - overlayHeight >= 50) {
        topPosition = offset.dy + size.height + 10;
      } else if (spaceAbove >= overlayHeight + verticalMargin) {
        topPosition = offset.dy - overlayHeight - 10;
        if (topPosition < minTopPosition) topPosition = minTopPosition;
      } else {
        // Not enough space above or below, clamp near bottom but above status bar
        topPosition = maxTopPosition;
        if (topPosition < minTopPosition) topPosition = minTopPosition;
      }

      topPosition = topPosition.clamp(minTopPosition, maxTopPosition);

      // Remove old overlay and insert new one at corrected position
      overlayEntry?.remove();

      overlayEntry = OverlayEntry(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (_) => removeOverlay(),
            onPanUpdate: (_) => removeOverlay(),
            onTap: removeOverlay,
            child: Stack(
              children: [
                Positioned(
                  left: (offset.dx - 66).clamp(
                    verticalMargin,
                    screenSize.width - overlayWidth - verticalMargin,
                  ),
                  top: topPosition,
                  width: overlayWidth,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: _buildOverlayContent(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      Overlay.of(context).insert(overlayEntry!);
    });
  }

  Widget _buildOverlayContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          trailing: SvgPicture.asset(Assets.images.profile.path),
          title: const Text(
            'View Profile',
            style: TextStyle(fontSize: 16, color: AppColors.color060518),
          ),
          onTap: () {
            removeOverlay();
            Get.toNamed(AppRoutes.userProfile);
          },
        ),
        Divider(color: AppColors.greyDivider.withOpacity(0.10)),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          trailing: SvgPicture.asset(Assets.images.blockUser.path),
          title: const Text(
            'Block User',
            style: TextStyle(fontSize: 16, color: AppColors.color060518),
          ),
          onTap: () {
            removeOverlay();
            showCustomBlockBottomSheet(
              context: context,
              title: 'Block “${widget.chat.name}”?',
            );
          },
        ),
        Divider(color: AppColors.greyDivider.withOpacity(0.10)),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          trailing: SvgPicture.asset(Assets.images.reportWarning.path),
          title: const Text(
            'Report',
            style: TextStyle(fontSize: 16, color: AppColors.color060518),
          ),
          onTap: () {
            removeOverlay();
            showClosableReportBottomSheet(
              context: context,
              title: 'Report “${widget.chat.name}”?',
            );
          },
        ),
      ],
    );
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (overlayEntry != null) {
          removeOverlay();
          final slidableState = Slidable.of(context);
          slidableState?.close();
          return false;
        }
        return true;
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 22,
          right: 23,
          left: 23,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          children: [
            Slidable(
              controller: widget.slidableController,
              key: ValueKey(widget.chat.chatId.toString()),
              closeOnScroll: true,
              endActionPane: ActionPane(
                extentRatio: 0.5,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    autoClose: false,
                    borderRadius: BorderRadius.circular(12),
                    onPressed: (context) {
                      final renderBox =
                          context.findRenderObject() as RenderBox?;
                      if (renderBox == null) return;
                      final size = renderBox.size;
                      final offset = renderBox.localToGlobal(Offset.zero);
                      showOverlay(context, offset, size);
                    },
                    label: 'More',
                    foregroundColor: AppColors.foundation500,
                    backgroundColor: AppColors.foundation50,
                    flex: 10,
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    label: '',
                    backgroundColor: AppColors.transparent,
                    flex: 1,
                  ),
                  SlidableAction(
                    borderRadius: BorderRadius.circular(12),
                    onPressed: (context) {
                      showCustomDeleteBottomSheet(
                        context: context,
                        title: 'Delete chat with ${widget.chat.name}?',
                      );
                    },
                    label: 'Delete',
                    backgroundColor: const Color(0xFFD84848),
                    flex: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        widget.chat.imagePath,
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chat.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: AppColors.color060518,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.chat.messagePreview,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: AppColors.color3C3E56),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.chat.unreadCount == 0)
                          Text(
                            widget.chat.time,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(
                              color: AppColors.foundationBlue100,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if (widget.chat.unreadCount > 0) ...[
                          SizedBox(height: 6.h),
                          Container(
                            height: 22.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5DCA54),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                widget.chat.unreadCount.toString(),
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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

Future<bool> showCustomDeleteBottomSheet({
  required BuildContext context,
  required String title,
  String? description, // made optional
  bool? check,
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
                if (check == true)
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
                if (description != null) ...[
                  const VerticalSpacing(12),
                  Text(
                    description,
                    style: context.text.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: AppColors.neutral600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const VerticalSpacing(21),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorF1F1F1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showBottomSheetForSent(
                              context: context,
                              title: '“User Name” Deleted',
                              description: 'This user has been deleted',
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Delete Chat',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.colorD82636,
                            ),
                          ),
                          trailing: SvgPicture.asset(Assets.images.redBin.path),
                        ),
                        AppDivider(color: AppColors.greyDivider),
                        ListTile(
                          onTap: () => Navigator.pop(context),
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Cancel',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.color060518,
                            ),
                          ),
                          trailing: SvgPicture.asset(
                            Assets.images.cancelIcon.path,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
  return true;
}

Future<bool> showCustomBlockBottomSheet({
  required BuildContext context,
  required String title,
  String? description, // made optional
  bool? check,
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
                if (check == true)
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
                if (description != null) ...[
                  const VerticalSpacing(12),
                  Text(
                    description,
                    style: context.text.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: AppColors.neutral600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const VerticalSpacing(35),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorF1F1F1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);

                            showBottomSheetForSent(
                              context: context,
                              title: '“User Name” Blocked',
                              description:
                                  'This user has been blocked. To unblock them, go to Settings > Account Privacy.',
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Block User',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.colorD82636,
                            ),
                          ),
                          trailing: SvgPicture.asset(Assets.images.report.path),
                        ),
                        AppDivider(color: AppColors.greyDivider),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Cancel',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.color060518,
                            ),
                          ),
                          trailing: SvgPicture.asset(
                            Assets.images.cancelIcon.path,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
  return true;
}

Future<bool> showClosableReportBottomSheet({
  required BuildContext context,
  required String title,
  String? description, // made optional
  bool? check,
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
                if (check == true)
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
                if (description != null) ...[
                  const VerticalSpacing(12),
                  Text(
                    description,
                    style: context.text.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: AppColors.neutral600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const VerticalSpacing(35),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorF1F1F1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showReportBottomSheetWithInputField(
                              context: context,
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Report User',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.colorD82636,
                            ),
                          ),
                          trailing: SvgPicture.asset(
                            Assets.images.warning.path,
                          ),
                        ),
                        AppDivider(color: AppColors.greyDivider),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          contentPadding: EdgeInsets.zero,
                          // Optional: removes side padding
                          dense: true,
                          // R
                          leading: Text(
                            'Cancel',
                            style: context.text.titleLarge?.copyWith(
                              color: AppColors.color060518,
                            ),
                          ),
                          trailing: SvgPicture.asset(
                            Assets.images.cancelIcon.path,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
  return true;
}

Future<void> showReportBottomSheetWithInputField({
  required BuildContext context,
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
              ).copyWith(bottom: 22 + context.devicePaddingBottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const VerticalSpacing(10),
                  Center(child: Assets.images.rectangle.svg()),
                  const VerticalSpacing(45),
                  Text(
                    "Report “User Name”",
                    style: context.text.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const VerticalSpacing(35),
                  AppTextFormField(
                    hintStyle: context.text.titleMedium!.copyWith(
                      color: AppColors.neutral600,
                    ),
                    hintText: 'Please share your reasons...',
                    maxLines: 6,
                  ),
                  const VerticalSpacing(19),
                  Center(
                    child: AppOutlinedButton(
                      height: 49,
                      text: 'SUBMIT',
                      onPressed: () async {
                        final rootContext = Navigator.of(
                          context,
                          rootNavigator: true,
                        );
                        Navigator.pop(context); // Close current sheet

                        await Future.delayed(
                          const Duration(milliseconds: 300),
                        ); // Small delay

                        await showBottomSheetForSent(
                          context: rootContext.context, // Use root context
                          title: 'Report Submitted',
                          description:
                              ' Our team will review it and get back to you as soon as possible.',
                        );
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
