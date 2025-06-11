import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/email_verification_form.dart';
import '../components/login_form.dart';
import '../components/matrix_rain_background.dart';
import '../components/password_reset_form.dart';
import '../components/sign_up_form.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final emailController = useTextEditingController();

    return MatrixRainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  const Spacer(),
                  Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/Logo_H.png'),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    flex: 4,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: [
                        LoginForm(
                          pageController: pageController,
                          emailController: emailController,
                        ),
                        SignUpForm(
                          pageController: pageController,
                          emailController: emailController,
                        ),
                        EmailVerificationForm(
                          pageController: pageController,
                          emailController: emailController,
                        ),
                        PasswordResetForm(
                          pageController: pageController,
                          emailController: emailController,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "VeilNet Rift v1.0.0 © 2025 VEILNET PTY LTD",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
