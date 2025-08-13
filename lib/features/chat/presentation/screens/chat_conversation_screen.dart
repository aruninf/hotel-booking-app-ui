import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
// Assuming you're using GetX for Get.height
import 'package:intl/intl.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_controller.dart';
import 'package:nudge/features/dashboard/presentation/screens/dashboard_screen.dart';

class ChatConversationScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final Function? onTap;

  const ChatConversationScreen({
    super.key,
    required this.name,
    required this.profileImage,
    this.onTap,
  });

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final controller = Get.find<ChatController>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool showMessage = false; // Moved here from inside build()
  @override
  void initState() {
    _scrollToBottom();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  final ImagePicker picker = ImagePicker();

  Future<void> selectImage() async {
    UiHelper.showloaderdialog(context);
    var photo = await picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(Get.overlayContext!);

    if (photo != null) {
      final imageFile = File(photo.path);
      controller.sendImageMessage(imageFile);
      setState(() {
        showMessage = true;
      });
      Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final slidableController = Get.find<ChatScreen>().slidableController;
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(DashboardScreen(initialIndex: 2));
        return false;
      },
      child: CustomScaffold(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Padding(
            padding: EdgeInsets.only(bottom: 5 + context.devicePaddingBottom),
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ).copyWith(top: 19 + context.devicePaddingTop),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          widget.onTap?.call() ?? Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.color111719,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.userConnected),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            widget.profileImage,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: context.text.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.color060518,
                            ),
                          ),
                          Text(
                            'Online',
                            style: context.text.titleSmall?.copyWith(
                              color: AppColors.color3C3E56,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(9),
                AppDivider(color: AppColors.dividerColor.withOpacity(0.11)),

                // Main Chat or Starter Section
                Expanded(
                  child:
                      showMessage
                          ? _buildChatConversation(controller)
                          : _buildConversationStarter(context),
                ),

                // Chat Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.neutral50),
                    ),
                    child: Row(
                      children: [
                        HorizontalSpacing(16),
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Write a message... ',
                              hintStyle: context.text.titleLarge?.copyWith(
                                color: AppColors.neutral600,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            onTap: () {
                              if (showMessage) {
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  _scrollToBottom,
                                );
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectImage();
                                _scrollToBottom();
                              },
                              child: SvgPicture.asset(
                                Assets.images.gallery.path,
                              ),
                            ),
                            HorizontalSpacing(8),
                            GestureDetector(
                              onTap: () {
                                final messageText = _textController.text;
                                if (messageText.trim().isEmpty) return;

                                controller.sendMessage(messageText);
                                _textController.clear();
                                setState(() {
                                  showMessage = true;
                                });
                                Future.delayed(
                                  Duration(milliseconds: 100),
                                  _scrollToBottom,
                                );
                              },
                              child: SvgPicture.asset(
                                Assets.images.sendMessage.path,
                              ),
                            ),
                            HorizontalSpacing(16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Starter UI before any message is sent
  Widget _buildConversationStarter(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -80,
          bottom: 12,
          child: Image.asset(
            Assets.images.gradientLogin4.path,
            width: 349,
            height: 322,
            fit: BoxFit.fill,
          ),
        ),
        SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: Get.height * 0.7),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.logoSVG.path,
                      height: 101,
                      width: 34,
                    ),
                    VerticalSpacing(18),
                    Text(
                      'Start a Conversation',
                      style: context.text.displaySmall?.copyWith(
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    VerticalSpacing(8),
                    Text(
                      'Break the ice and make a connection',
                      style: context.text.titleLarge?.copyWith(
                        color: AppColors.neutral600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    VerticalSpacing(18),
                    _buildStarterButton(
                      text: 'Saw you’re into [shared interest] - me too!',
                      onPressed: () {},
                    ),
                    VerticalSpacing(12),
                    _buildStarterButton(
                      text: 'Hey! We were both at [event], what did you think?',
                      onPressed: () {},
                    ),
                    VerticalSpacing(12),
                    _buildStarterButton(
                      text: 'Hii! What do you think about [event]?',
                      onPressed: () {
                        setState(() {
                          showMessage = true;
                        });
                        _scrollToBottom();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Reusable button builder for starter suggestions
  Widget _buildStarterButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.foundation50),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: context.text.titleSmall?.copyWith(
            color: AppColors.foundationPrimary500,
          ),
        ),
      ),
    );
  }

  // Actual chat message list
  Widget _buildChatConversation(ChatController controller) {
    return Obx(() {
      final messages = controller.chatMessages;
      DateTime? lastMessageDate;

      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final isSender = msg.isSender;

          final currentDate = DateTime(
            msg.date.year,
            msg.date.month,
            msg.date.day,
          );

          final now = DateTime.now();
          final difference = now.difference(currentDate).inDays;

          bool showDateLabel = false;

          // Show date label only for received messages and when the date is different from the previous message
          if (!isSender) {
            if (lastMessageDate == null || currentDate != lastMessageDate) {
              showDateLabel = true;
              lastMessageDate = currentDate;
            }
          }

          final isLast = index == messages.length - 1;
          final nextMsgIsSender = !isLast ? messages[index + 1].isSender : null;
          final showTime = isLast || (nextMsgIsSender != isSender);

          return Column(
            children: [
              Align(
                alignment:
                    isSender ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment:
                      isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isSender) ...[
                          Image.asset(
                            widget.profileImage,
                            height: 23,
                            width: 23,
                          ),
                          HorizontalSpacing(8),
                        ],
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSender
                                      ? AppColors.color3964FF
                                      : AppColors.colorF1F1F1,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20),
                                topRight: const Radius.circular(20),
                                bottomLeft: Radius.circular(isSender ? 20 : 8),
                                bottomRight: Radius.circular(isSender ? 8 : 20),
                              ),
                            ),
                            child:
                                msg.imageFile != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        msg.imageFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : Text(
                                      msg.message ?? '',
                                      style: context.text.titleMedium?.copyWith(
                                        color:
                                            isSender
                                                ? AppColors.white
                                                : AppColors.boldTextColor,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                    if (showTime)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: 17,
                          left: 30,
                        ),
                        child: Text(
                          DateFormat('hh:mm a').format(msg.time),
                          style: context.text.titleSmall?.copyWith(
                            color: AppColors.color212221.withOpacity(0.6),
                            fontSize: 9,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (showDateLabel)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      difference > 7
                          ? DateFormat('d MMMM, yyyy').format(currentDate)
                          : _getRelativeDateLabel(currentDate),
                      style: context.text.titleMedium?.copyWith(
                        color: AppColors.color212221.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              VerticalSpacing(5),
            ],
          );
        },
      );
    });
  }

  String _getRelativeDateLabel(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return DateFormat.EEEE().format(date); // e.g., Monday

    return DateFormat('MMM d, yyyy').format(date); // e.g., Apr 20, 2025
  }
}
