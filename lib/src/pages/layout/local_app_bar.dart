import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/theme_provider.dart';

class LocalAppBar extends StatelessWidget {
  const LocalAppBar({
    Key? key,
    required this.child,
    this.title,
  }) : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  onTap: () => GoRouter.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 20.0,
                  ),
                  child: Text(
                    title!.toUpperCase(),
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
