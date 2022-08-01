import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/auth_provider.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, provider, __) => IgnorePointer(
        ignoring: provider.isLoading,
        child: provider.isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/google_logo.svg',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Sign in with Google',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    onPressed: () => provider.signInWithGoogle(),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () => provider.skipAuth(),
                  ),
                ],
              ),
      ),
    );
  }
}
