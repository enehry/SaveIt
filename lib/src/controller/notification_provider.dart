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
    '"You must gain control over your money, or the lack of it will forever control you." Save up in Shareit add your desired goal now!',
    "Hey! You haven't set your Saving Allocation, Set now with Saveit you can configure your allocation to your liking!",
    '"Do not save what is left after spending, but spend what is left after saving." – Warren Buffett. Save and track your money with Saveit!',
    '"Never spend your money before you have it." – Thomas Jefferson. Daily reminder from Saveit!',
    'Saveit here! Daily reminder to track your savings!',
    'Saving is successful if you do it. SaveIt now.',
    "The more money you put away today, the more security you'll have in the future. SaveIt now.",
    "Stop spending money on unnecessary items to impress people you don't even like.",
    "Money appears more attractive on the SaveIt app than on your feet.",
    "If you save money, you'll eventually be able to support yourself.",
    "While you can focus on saving coffee you must be focus on saving money too. Don’t hesitate! Go and Saveit!",
    'Hurry Up! The clock is ticking! Don’t waste time, just Saveit now!',
    'If you are saving money, you are succeeding. Let’s Go! Saveit now!',
    'Wow! You stand out. Make sure your income should too. Start now and Saveit now!',
    'Hey there! It is not about how much money you make, It is all about how you Saveit!',
    "If you're saving, you're succeeding.what are you waiting for use Saveit to save money now.",
    'It takes as much energy to wish as it does to plan. Stop wishing and set up a plan in Saveit to start saving now.',
    "You are never too old to set another goal or to dream a new dream, so better start saving money on Saveit.",
    "Money doesn't buy happiness, it buys crazy ass happiness -Eminem be like eminem buy your own hapiness but first save up in Saveit and reach your goal.",
    "Don't be a dummy and save your money. Open Saveit and save up to reach your desired goal.",
    "There is a gigantic difference between having a money and saving money. You should save money and Saveit!",
    "If you cannot do great things, do small things by saving money. Save now and track your savings with Saveit!",
  ];

  //
  Future<void> saveITScheduledNotification(int interval) async {
    if (interval == 60) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(100),
          channelKey: 'scheduled_channel',
          title: 'Save It Quote of The Day',
          body: quotes[Random().nextInt(quotes.length - 1)],
          notificationLayout: NotificationLayout.BigText,
          fullScreenIntent: true,
        ),
      );
      return;
    }

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
