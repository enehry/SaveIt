import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/bottom_nav_provider.dart';
import 'package:save_it/src/loading_screen.dart';
import 'package:save_it/src/pages/layout/bottom_nav_bar.dart';
import 'package:save_it/src/pages/layout/transparent_app_bar.dart';

class Authenticated extends StatefulWidget {
  const Authenticated({Key? key}) : super(key: key);

  @override
  State<Authenticated> createState() => _AuthenticatedState();
}

class _AuthenticatedState extends State<Authenticated> {
  bool isLoadingScreen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoadingScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingScreen
        ? const LoadingScreen()
        : Consumer<BottomNavProvider>(
            builder: (_, provider, __) => TransparentAppBar(
              bottomNavBar: const BottomNavBar(),
              title: provider.pageTitle,
              child: provider.currentPage,
            ),
          );
  }
}
