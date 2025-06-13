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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: LayoutBuilder(
                builder:
                    (context, constraints) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight * 0.6,
                        maxWidth: constraints.maxWidth * 0.9,
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/images/Logo_H.png', height: 100),
                          const SizedBox(height: 16),
                          Expanded(
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
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
