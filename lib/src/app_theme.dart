import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/theme_provider.dart';
import 'package:save_it/src/router.dart';
import 'package:save_it/src/theme/themes.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
    );
  }
}
