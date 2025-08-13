import 'package:get/get.dart';
import 'package:nudge/features/push_notification_settings/data/source/push_notification_settings_remote_source.dart';

class PushNotificationSettingsController extends GetxController {
  PushNotificationSettingsController({required this.remoteSource});

  final PushNotificationSettingsRemoteSource remoteSource;

  RxBool allPushNotification = false.obs;
  RxBool notification1 = true.obs;
  RxBool notification2 = false.obs;
  RxBool notification3 = true.obs;
  RxBool notification4 = true.obs;
  RxBool notification5 = false.obs;
  RxBool notification6 = false.obs;
  RxBool notification7 = false.obs;

  List<RxBool> get notificationList => [
    notification1,
    notification2,
    notification3,
    notification4,
    notification5,
    notification6,
    notification7,
  ];

  void toggleAllNotifications(bool value) {
    allPushNotification.value = value;
    for (var noti in notificationList) {
      noti.value = value;
    }
  }

  void toggleSingleNotification(int index, bool value) {
    notificationList[index].value = value;

    if (notificationList.every((noti) => noti.value)) {
      allPushNotification.value = true;
    } else {
      allPushNotification.value = false;
    }
  }
}
