import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/presentation/controllers/chat_controller.dart';
import 'package:nudge/features/chat/presentation/screens/chat_conversation_screen.dart';
import 'package:nudge/features/chat/presentation/screens/widgets/chat_list_item.dart';
import 'package:nudge/features/home/presentation/controllers/home_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  // final SlidableController slidableController;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late List<SlidableController> _slidableControllers;
  late List<GlobalKey<ChatListItemState>> _itemKeys;

  void closeAllSlidables() {
    for (final controller in _slidableControllers) {
      controller.close();
    }
    setState(() {}); // Add if needed to force rebuild, but usually not needed.
  }

  @override
  void initState() {
    super.initState();
    final chatController = Get.find<ChatController>();

    // Create a SlidableController for each item with `this` as TickerProvider
    _slidableControllers = List.generate(
      chatController.chatItems.length,
      (_) => SlidableController(this),
    );
    _itemKeys = List.generate(
      chatController.chatItems.length,
      (_) => GlobalKey<ChatListItemState>(),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
    for (final controller in _slidableControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     systemNavigationBarColor: AppColors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarColor: AppColors.primaryContainerColor,
    //     statusBarIconBrightness: Brightness.light));
    final controller = Get.find<ChatController>();
    return WillPopScope(
      onWillPop: () async {
        for (final controller in _slidableControllers) {
          controller.close(); // Close if open
        }
        return true;
      },
      child: CustomScaffold(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            surfaceTintColor: AppColors.transparent,
            // backgroundColor: AppColors.transparent,
            title: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Chat',
                style: context.text.displaySmall?.copyWith(
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0,
            ).copyWith(bottom: min(context.devicePaddingBottom, 50)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 18, right: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextFormFieldWithoutLabel(
                          controller: homeController.chatSearchController,
                          hintText: 'Search ...',
                          hintStyle: context.text.bodyMedium!.copyWith(
                            fontSize: 14,
                            color: Color(0x80616679),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                          prefixIcon: Icon(Icons.arrow_back_ios_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollStartNotification) {
                        FocusScope.of(context).unfocus(); // Hides the keyboard
                        // Hide all overlays
                        for (final key in _itemKeys) {
                          key.currentState?.removeOverlay();
                        }
                      }
                      return false;
                    },
                    child: Container(
                      child: Obx(
                        () => SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: controller.chatItems.length,
                            itemBuilder: (context, index) {
                              final chat = controller.chatItems[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ChatConversationScreen(
                                      name: chat.name,
                                      profileImage: chat.imagePath,
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 75,
                                  child: ChatListItem(
                                    key: _itemKeys[index],
                                    chat: controller.chatItems[index],
                                    slidableController:
                                        _slidableControllers[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
}
