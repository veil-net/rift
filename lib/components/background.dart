import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimatedGradientBackground extends HookConsumerWidget {
  final Widget child;
  const AnimatedGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 5),
    )..repeat();

    final curvedAnimation = useMemoized(() {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      );
    }, [controller]);

    final beginAlignment = useMemoized(() {
      return TweenSequence<Alignment>([
        TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.topLeft),
          weight: 1,
        ),
      ]).animate(curvedAnimation);
    }, [curvedAnimation]);

    final endAlignment = useMemoized(() {
      return TweenSequence<Alignment>([
        TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomRight, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.topRight, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.topLeft, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: Alignment.bottomLeft, end: Alignment.bottomRight),
          weight: 1,
        ),
      ]).animate(curvedAnimation);
    }, [curvedAnimation]);

    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: beginAlignment.value,
              end: endAlignment.value,
              colors: [
                colorScheme.primary.withAlpha(50),
                colorScheme.secondary.withAlpha(50),
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
