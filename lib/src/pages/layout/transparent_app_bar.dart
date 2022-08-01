import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/theme_provider.dart';

GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

class TransparentAppBar extends StatelessWidget {
  const TransparentAppBar({
    Key? key,
    required this.child,
    this.title,
    this.bottomNavBar,
    this.hasBackButton = false,
  }) : super(key: key);

  final Widget child;
  final Widget? bottomNavBar;
  final String? title;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                context.watch<ThemeProvider>().themeMode == ThemeMode.dark
                    ? Brightness.light
                    : Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      // bottom navigation
      bottomNavigationBar: bottomNavBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
