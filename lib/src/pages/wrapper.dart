import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/auth_provider.dart';
import 'package:save_it/src/pages/auth/sign_in_page.dart';
import 'package:save_it/src/pages/authenticated.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    // pop up confirmation notification
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('SaveIt needs to send you notifications.'),
            actions: [
              TextButton(
                child: const Text('Don\'t Allow'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Allow'),
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then(
                      (value) => Navigator.of(context).pop(),
                    ),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, provider, __) =>
          provider.isSignedIn ? const Authenticated() : const SignInPage(),
    );
  }
}
