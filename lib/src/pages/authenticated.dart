import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/bottom_nav_provider.dart';
import 'package:save_it/src/pages/layout/bottom_nav_bar.dart';
import 'package:save_it/src/pages/layout/transparent_app_bar.dart';

class Authenticated extends StatelessWidget {
  const Authenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (_, provider, __) => TransparentAppBar(
        bottomNavBar: const BottomNavBar(),
        title: provider.pageTitle,
        child: provider.currentPage,
      ),
    );
  }
}
