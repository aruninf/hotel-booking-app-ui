import 'package:get/get.dart';
import 'package:nudge/features/email_notification/data/source/email_notification_remote_source.dart';

class EmailNotificationController extends GetxController {
  EmailNotificationController({required this.remoteSource});

  final EmailNotificationRemoteSource remoteSource;

  RxBool allEmailNotification = false.obs;
  RxBool notification1 = true.obs;
  RxBool notification2 = false.obs;
  RxBool notification3 = true.obs;
  RxBool notification4 = false.obs;

  List<RxBool> get notificationList => [
    notification1,
    notification2,
    notification3,
    notification4,
  ];

  void toggleAllNotifications(bool value) {
    allEmailNotification.value = value;
    for (var noti in notificationList) {
      noti.value = value;
    }
  }

  void toggleSingleNotification(int index, bool value) {
    notificationList[index].value = value;

    if (notificationList.every((noti) => noti.value)) {
      allEmailNotification.value = true;
    } else {
      allEmailNotification.value = false;
    }
  }
}
