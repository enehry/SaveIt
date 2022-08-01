import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:save_it/src/utils/constant.dart';

class NotificationProvider with ChangeNotifier {
  late int _notificationInterval;
  final Box _notificationBox;

  int get notificationInterval => _notificationInterval;

  set notificationInterval(int value) {
    _notificationInterval = value;
    notifyListeners();
    // put the value in the box
    _notificationBox.put(kNotificationData, _notificationInterval);
  }

  NotificationProvider(this._notificationBox) {
    _notificationInterval = _notificationBox.get(kNotificationData) ?? 0;
    notifyListeners();
  }

  //
  Future<void> saveITScheduledNotification(int interval) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100),
        channelKey: 'scheduled_channel',
        title:
            'Save IT - Scheduled Notification - ${DateTime.now().toString()}',
        body: 'This is a scheduled notification.',
        notificationLayout: NotificationLayout.BigText,
      ),
      // pop up notification every minute
      schedule: NotificationInterval(
        interval: interval,
        repeats: true,
        timeZone: localTimeZone,
      ),
    );
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
