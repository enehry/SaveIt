import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.0,
              child: Image.asset('assets/icons/SaveitLOGO.png'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              width: 100.0,
              child: LinearProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
