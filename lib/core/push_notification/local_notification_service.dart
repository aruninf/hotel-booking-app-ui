// import 'package:nudge/constants/app_colors.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   factory LocalNotificationService() => _instance;

//   LocalNotificationService._internal() {
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   }

//   static final LocalNotificationService _instance =
//       LocalNotificationService._internal();
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   Future<void> initialize({
//     void Function(NotificationResponse)? onDidReceiveNotificationResponse,
//   }) async {
//     const androidInitializationSettings = AndroidInitializationSettings(
//       '@mipmap/launcher_icon',
//     );

//     const channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//     );

//     const iosInitializationSettings = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     const initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   }

//   @pragma('vm:entry-point')
//   static void notificationTapBackground(
//     NotificationResponse notificationResponse,
//   ) {
//     // Handle background tap
//     print('Notification tapped: ${notificationResponse.payload}');
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     const androidNotificationDetails = AndroidNotificationDetails(
//       'high_importance_channel',
//       'Notifications',
//       channelDescription: 'Your channel description',
//       importance: Importance.high,
//       priority: Priority.high,
//       icon: '@mipmap/launcher_icon',
//       color: AppColors.primaryDark,
//     );

//     final notification = message.notification;
//     final android = notification?.android;

//     final payload = message.notification?.title?.toLowerCase() ?? '';

//     print('Showing notification with payload: $payload');

//     if (notification != null && android != null) {
//       _flutterLocalNotificationsPlugin.show(
//         message.hashCode,
//         notification.title ?? 'No title',
//         notification.body ?? 'No body',
//         const NotificationDetails(android: androidNotificationDetails),
//         payload: payload,
//       );
//     } else {
//       print('Notification data is missing.');
//     }
//   }
// }
