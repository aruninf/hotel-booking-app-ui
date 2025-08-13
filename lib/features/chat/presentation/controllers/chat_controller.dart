import 'dart:io';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/chat/data/source/chat_remote_source.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  ChatController({required this.remoteSource});

  // late SlidableController slidableController;

  final ChatRemoteSource remoteSource;
  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  // Function to send a message
  final Map<int, SlidableController> slidableControllers = {};

  @override
  void onInit() {
    super.onInit();
    // slidableController = SlidableController(this);
    for (var item in chatItems) {
      slidableControllers[item.chatId] = SlidableController(this);
    }
  }

  void closeSlidable() {
    // slidableController.close();
  }

  @override
  void onClose() {
    // slidableController.dispose();
    super.onClose();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    chatMessages.add(
      ChatMessage(
        message: text.trim(),
        isSender: true,
        time: DateTime.now(), // Store the current DateTime directly
        date: DateTime.now(),
      ),
    );
  }

  // List of chat items for the chat overview (can be used for a list of conversations)
  final RxList<ChatItem> chatItems =
      <ChatItem>[
        ChatItem(
          chatId: 1,
          name: 'Sarah Smith',
          messagePreview: 'Lorem ipsum dolor sit amet, conse...',
          time: '12:37',
          unreadCount: 2,
          imagePath: Assets.images.img1.path,
        ),
        ChatItem(
          chatId: 1,
          name: 'Sarah Smith',
          messagePreview: 'Lorem ipsum dolor sit amet, conse...',
          time: '12:37',
          unreadCount: 2,
          imagePath: Assets.images.img1.path,
        ),
        ChatItem(
          chatId: 1,
          name: 'Sarah Smith',
          messagePreview: 'Lorem ipsum dolor sit amet, conse...',
          time: '12:37',
          unreadCount: 2,
          imagePath: Assets.images.img1.path,
        ),
        ChatItem(
          chatId: 2,
          name: 'David Johnson',
          messagePreview: 'Hey! Are you joining the meeting?',
          time: '11:15',
          unreadCount: 0,
          imagePath: Assets.images.img2.path,
        ),
        ChatItem(
          chatId: 3,
          name: 'David Johnson',
          messagePreview: 'Hey! Are you joining the meeting?',
          time: '11:15',
          unreadCount: 0,
          imagePath: Assets.images.img2.path,
        ),
        ChatItem(
          chatId: 4,
          name: 'David Johnson',
          messagePreview: 'Hey! Are you joining the meeting?',
          time: '11:15',
          unreadCount: 0,
          imagePath: Assets.images.img2.path,
        ),
        ChatItem(
          chatId: 7,
          name: 'David Johnson',
          messagePreview: 'Hey! Are you joining the meeting?',
          time: '11:15',
          unreadCount: 0,
          imagePath: Assets.images.img2.path,
        ),
        ChatItem(
          chatId: 5,
          name: 'David Johnson',
          messagePreview: 'Hey! Are you joining the meeting?',
          time: '11:15',
          unreadCount: 0,
          imagePath: Assets.images.img2.path,
        ),
        ChatItem(
          chatId: 9,
          name: 'Emily Brown',
          messagePreview: 'Thanks for the update.',
          time: 'Yesterday',
          unreadCount: 3,
          imagePath: Assets.images.img3.path,
        ),
        ChatItem(
          chatId: 11,
          name: 'Emily Brown',
          messagePreview: 'Thanks for the update.',
          time: 'Yesterday',
          unreadCount: 3,
          imagePath: Assets.images.img3.path,
        ),
      ].obs;

  // List of individual chat messages for a specific conversation
  final RxList<ChatMessage> chatMessages =
      <ChatMessage>[
        ChatMessage(
          message: "Hey, how are you?",
          isSender: false,
          time: DateTime(2025, 5, 13, 10, 30), // Store DateTime
          date: DateTime(2025, 5, 13),
        ),
        ChatMessage(
          message: "I'm good, what about you?",
          isSender: true,
          time: DateTime(2025, 5, 13, 10, 31),
          date: DateTime(2025, 5, 13),
        ),
        ChatMessage(
          message: "I'm doing well, just working on a project.",
          isSender: false,
          time: DateTime(2025, 5, 13, 10, 32),
          date: DateTime(2025, 5, 13),
        ),
        ChatMessage(
          message: "Nice! Good luck with it. Nice! Good luck with it.",
          isSender: true,
          time: DateTime(2025, 5, 13, 10, 33),
          date: DateTime(2025, 5, 13),
        ),
        ChatMessage(
          message: "Nice! Good luck with it.",
          isSender: true,
          time: DateTime(2025, 5, 14, 10, 33),
          date: DateTime(2025, 5, 14),
        ),
        // Dummy messages from 7 days ago
        ChatMessage(
          message: "How's your project going?",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 7, hours: 10),
          ), // 7 days ago
          date: DateTime.now().subtract(Duration(days: 7)),
        ),
        ChatMessage(
          message: "It's going well, thanks for asking!",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 7, hours: 9),
          ), // 7 days ago
          date: DateTime.now().subtract(Duration(days: 7)),
        ),
        ChatMessage(
          message: "Nice to hear that. Keep it up!",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 7, hours: 8),
          ), // 7 days ago
          date: DateTime.now().subtract(Duration(days: 7)),
        ),
        ChatMessage(
          message: "Appreciate it!",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 7, hours: 7),
          ), // 7 days ago
          date: DateTime.now().subtract(Duration(days: 7)),
        ),
        // Dummy messages from 6 days ago
        ChatMessage(
          message: "Did you finish that feature?",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 6, hours: 10),
          ), // 6 days ago
          date: DateTime.now().subtract(Duration(days: 6)),
        ),
        ChatMessage(
          message: "Yes, it’s ready to be tested!",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 6, hours: 9),
          ), // 6 days ago
          date: DateTime.now().subtract(Duration(days: 6)),
        ),
        // Dummy messages from 5 days ago
        ChatMessage(
          message: "How's the new project going?",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 5, hours: 10),
          ), // 5 days ago
          date: DateTime.now().subtract(Duration(days: 5)),
        ),
        ChatMessage(
          message: "It's going well! Just making good progress.",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 5, hours: 9),
          ), // 5 days ago
          date: DateTime.now().subtract(Duration(days: 5)),
        ),
        // Dummy messages from 4 days ago
        ChatMessage(
          message: "Did you get a chance to review the docs?",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 4, hours: 10),
          ), // 4 days ago
          date: DateTime.now().subtract(Duration(days: 4)),
        ),
        ChatMessage(
          message: "Yes, I reviewed them yesterday.",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 4, hours: 9),
          ), // 4 days ago
          date: DateTime.now().subtract(Duration(days: 4)),
        ),
        // Dummy messages from 3 days ago
        ChatMessage(
          message: "What’s the next step in the project?",
          isSender: false,
          time: DateTime.now().subtract(
            Duration(days: 3, hours: 10),
          ), // 3 days ago
          date: DateTime.now().subtract(Duration(days: 3)),
        ),
        ChatMessage(
          message: "We need to finalize the design first.",
          isSender: true,
          time: DateTime.now().subtract(
            Duration(days: 3, hours: 9),
          ), // 3 days ago
          date: DateTime.now().subtract(Duration(days: 3)),
        ),
      ].obs;

  // Format the time to be displayed as a string
  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  void sendImageMessage(File imageFile) {
    final now = DateTime.now();
    chatMessages.add(
      ChatMessage(
        message: null,
        imageFile: imageFile,
        isSender: true,
        date: now,
        time: now,
      ),
    );
  }
}

// ChatItem class for overview or list of conversations
class ChatItem {
  final int chatId;
  final String name;
  final String messagePreview;
  final String time; // This can be a string (for UI purposes)
  final int unreadCount;
  final String imagePath;

  ChatItem({
    required this.chatId,
    required this.name,
    required this.messagePreview,
    required this.time,
    required this.unreadCount,
    required this.imagePath,
  });
}

// ChatMessage class for the details of individual messages
class ChatMessage {
  final String? message;
  final File? imageFile;
  final bool isSender;
  final DateTime date;
  final DateTime time;

  ChatMessage({
    this.message,
    this.imageFile,
    required this.isSender,
    required this.date,
    required this.time,
  });
}
