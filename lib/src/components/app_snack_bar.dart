import 'package:flutter/material.dart';
import 'package:save_it/src/pages/layout/transparent_app_bar.dart';

class AppSnackBar {
  final String message;
  final Color color;
  final Icon icon;

  AppSnackBar({
    required this.message,
    required this.icon,
    this.color = const Color(0xFF292524),
  });

  void showSnackBar() {
    if (globalScaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(globalScaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10.0),
          backgroundColor: color,
          content: Row(children: [
            icon,
            const SizedBox(width: 10.0),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ]),
        ),
      );
    }
  }
}
