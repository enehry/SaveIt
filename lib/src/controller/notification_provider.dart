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

  final List<String> quotes = [
    '"The best way to predict the future is to create it." - Abraham Lincoln',
    '"The future belongs to those who believe in the beauty of their dreams." - Eleanor Roosevelt',
    '"The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart." - Helen Keller',
    '"I have not failed. I\'nve just found 10,000 ways that won\'t work." - Thomas A. Edison',
    '"The only way to do great work is to love what you do." - Steve Jobs',
    '"The only way to get the full value of joy is to love what you do." - Frank Lloyd Wright',
    '"The best way to predict the future is to create it." - Abraham Lincoln',
    '"The future belongs to those who believe in the beauty of their dreams." - Eleanor Roosevelt',
    '"The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart." - Helen Keller',
    '"I have not failed. I\'ve just found 10,000 ways that won\'t work." - Thomas A. Edison',
    '"The only way to do great work is to love what you do." - Steve Jobs',
    '"The only way to get the full value of joy is to love what you do." - Frank Lloyd Wright',
  ];

  //
  Future<void> saveITScheduledNotification(int interval) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(100),
        channelKey: 'scheduled_channel',
        title: 'Save It Quote of The Day',
        body: quotes[Random().nextInt(quotes.length)],
        notificationLayout: NotificationLayout.BigText,
        fullScreenIntent: true,
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
