import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/app.dart';
import 'package:save_it/src/controller/auth_provider.dart';
import 'package:save_it/src/controller/notification_provider.dart';
import 'package:save_it/src/controller/theme_provider.dart';
import 'package:save_it/src/models/challenge.dart';
import 'package:save_it/src/models/deposit.dart';
import 'package:save_it/src/utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ChallengesAdapter());
  Hive.registerAdapter(DepositAdapter());
  final themeModeBox = await Hive.openBox(kThemeModeBox);
  final notificationBox = await Hive.openBox(kNotificationBox);
  await Hive.openBox<Challenge>(kChallengeBox);
  final authBox = await Hive.openBox(kAuthBox);

  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Scheduled Notifications for Save IT application',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(themeModeBox),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(notificationBox),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authBox),
          lazy: true,
        ),
      ],
      child: const App(),
    ),
  );
}
