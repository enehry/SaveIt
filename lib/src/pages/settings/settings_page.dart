import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/auth_provider.dart';
import 'package:save_it/src/controller/notification_provider.dart';
import 'package:save_it/src/controller/theme_provider.dart';
import 'package:save_it/src/utils/constant.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  final title = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(bottom: 10.0),
          title: Text(
            'Change Theme',
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(
            'You can change theme by selecting it on the dropdown menu (default system).',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: DropdownButton<ThemeMode>(
            // no border
            underline: Container(
              height: 0,
            ),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            value: context.watch<ThemeProvider>().themeMode,
            onChanged: (ThemeMode? themeMode) {
              context.read<ThemeProvider>().themeMode =
                  themeMode ?? ThemeMode.system;
            },
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark'),
              ),
            ],
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(bottom: 10),
          title: Text(
            'Notifications',
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(
            'You can set the interval of the notifications or you can turn it off.',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: DropdownButton<int>(
            // no border
            underline: Container(
              height: 0,
            ),
            value: context.watch<NotificationProvider>().notificationInterval,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            onChanged: (value) async {
              // check if 0 if it is then cancel all notifications
              context.read<NotificationProvider>().notificationInterval =
                  value!;
              if (value == 0) {
                await context
                    .read<NotificationProvider>()
                    .cancelScheduledNotifications();
                return;
              }
              await context
                  .read<NotificationProvider>()
                  .saveITScheduledNotification(value);
            },
            items: kNotificationIntervals
                .map(
                  (interval) => DropdownMenuItem<int>(
                    value: interval.interval,
                    child: Text(interval.title),
                  ),
                )
                .toList(),
          ),
        ),
        StreamBuilder<User?>(
          stream: context.read<AuthProvider>().userStream,
          builder: ((context, snapshot) {
            // check if user is null
            if (snapshot.hasError) {
              return const Text('Error');
            }

            if (snapshot.hasData) {
              return ListTile(
                onTap: () {
                  // show dialog to ask if user really wants to logout
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            context.read<AuthProvider>().signOut();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                contentPadding: const EdgeInsets.only(bottom: 10.0),
                isThreeLine: true,
                title: Text(
                  'Sign out',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.email!),
                    Text(
                      'Signing out will remove account sync.',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              );
            }
            return ListTile(
              onTap: () {
                // show dialog to ask if user really wants to logout
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          context.read<AuthProvider>().signInWithGoogle();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              contentPadding: const EdgeInsets.only(bottom: 10.0),
              title: Text(
                'Sign In',
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                'Sign in your google account to sync your data.',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            );
          }),
        )
      ],
    );
  }
}
