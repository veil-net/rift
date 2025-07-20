import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/background.dart';

class LandingPage extends HookConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 0, end: 1),
            builder:
                (context, value, child) => Image.asset(
                  'assets/images/Logo_V.png',
                  width: 400 * value,
                  height: 400 * value,
                ),
          ),
        ),
      ),
    );
  }
}
