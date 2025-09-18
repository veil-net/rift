import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/background.dart';
import 'package:rift/components/auth/verify_email_form.dart';

class VerifyEmailPage extends HookConsumerWidget {
  final String? email;
  const VerifyEmailPage({super.key, this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(begin: 0, end: 1),
                      builder:
                          (context, value, child) => Opacity(
                            opacity: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Hero(
                                tag: 'logo',
                                child: Image.asset('assets/images/Logo_H.png'),
                              ),
                            ),
                          ),
                    ),
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(begin: 1, end: 0),
                      builder:
                          (context, value, child) => Transform.translate(
                            offset: Offset(0, value * 100),
                            child: child,
                          ),
                      child: EmailVerificationForm(email: email),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
