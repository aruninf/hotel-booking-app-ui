// import 'package:nudge/core/push_notification/local_notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// class FirebaseNotificationService extends GetxService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   Future<FirebaseNotificationService> init() async {
//     await requestPermission();
//     configureFirebaseListeners();
//     await getToken();
//     return this;
//   }

//   Future<void> requestPermission() async {
//     var settings = await _firebaseMessaging.requestPermission(
//       provisional: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   Future<void> setForegroundNotificationOptions() async {
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   Future<String?> getToken() async {
//     try {
//       var token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         print('FCM Token: $token');
//       } else {
//         print('Failed to retrieve FCM token');
//       }
//       return token;
//     } catch (e) {
//       print('Error getting FCM token: $e');
//       return null;
//     }
//   }

//   void configureFirebaseListeners() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground message received: ${message.notification?.title}');
//       LocalNotificationService().showNotification(message);
//     });
//   }

//   static Future<void> _firebaseBackgroundMessageHandler(
//     RemoteMessage message,
//   ) async {
//     LocalNotificationService().showNotification(message);
//   }
// }

// class NotificationBindings extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(FirebaseNotificationService()..configureFirebaseListeners());
//   }
// }

// class NotificationInitializer {
//   static void initialize() {
//     Get.put(FirebaseNotificationService()..configureFirebaseListeners());
//   }

//   static void destroy() {
//     Get.delete<FirebaseNotificationService>();
//   }
// }
