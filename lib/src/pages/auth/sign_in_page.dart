import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_it/src/pages/auth/sign_in_button.dart';
import 'package:save_it/src/utils/constant.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingNormal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello!', style: Theme.of(context).textTheme.headline2),
              Text(
                'Welcome to SaveIt!',
                style: Theme.of(context).textTheme.headline3,
              ),
              Flexible(
                flex: 2,
                child: SvgPicture.asset(
                  'assets/svgs/sign_in_bg.svg',
                  width: double.infinity,
                  height: 400.0,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'You can login using your google account or skip for now if you don’t want to sync your data.',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              const SignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
