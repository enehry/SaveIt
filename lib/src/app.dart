import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/app_theme.dart';
import 'package:save_it/src/providers.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const AppTheme(),
    );
  }
}
