import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const int numParticles = 50;
const double maxDistance = 100;
final _random = Random();

class Particle {
  Offset beginPosition;
  Offset endPosition;
  Offset easedPosition;

  Particle(this.beginPosition, this.endPosition, this.easedPosition);
}

final particlesProvider =
    StateNotifierProvider<_ParticlesNotifier, List<Particle>>((ref) {
      return _ParticlesNotifier();
    });

class _ParticlesNotifier extends StateNotifier<List<Particle>> {
  _ParticlesNotifier() : super(_generateParticles());

  static List<Particle> _generateParticles() {
    return List.generate(numParticles, (_) {
      final beginPosition = Offset(_random.nextDouble(), _random.nextDouble());
      final endPosition = Offset(_random.nextDouble(), _random.nextDouble());
      return Particle(beginPosition, endPosition, beginPosition);
    });
  }

  void update() {
    final newState = <Particle>[];
    for (final p in state) {
      final easedPosition = Offset.lerp(p.easedPosition, p.endPosition, 0.005)!;
      if ((easedPosition - p.endPosition).distance > 0.001) {
        newState.add(Particle(p.beginPosition, p.endPosition, easedPosition));
      } else {
        final beginPosition = Offset(
          _random.nextDouble(),
          _random.nextDouble(),
        );
        final endPosition = Offset(_random.nextDouble(), _random.nextDouble());
        newState.add(Particle(beginPosition, endPosition, beginPosition));
      }
    }
    state = newState;
  }
}

class AnimatedBackground extends HookConsumerWidget {
  final Widget child;
  const AnimatedBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 5),
    )..repeat();

    useEffect(() {
      void tick() {
        ref.read(particlesProvider.notifier).update();
      }

      controller.addListener(tick);
      return () => controller.removeListener(tick);
    }, [controller]);

    final particles = ref.watch(particlesProvider);

    return Stack(
      children: [
        Container(color: Theme.of(context).colorScheme.surface),

        Positioned.fill(
          child: RepaintBoundary(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: CustomPaint(
                painter: _ParticlesPainter(particles, context),
                size: Size.infinite,
              ),
            ),
          ),
        ),

        child,
      ],
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final BuildContext context;
  _ParticlesPainter(this.particles, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final particlePositions =
        particles
            .map(
              (p) => Offset(
                p.easedPosition.dx * size.width,
                p.easedPosition.dy * size.height,
              ),
            )
            .toList();

    for (int i = 0; i < particlePositions.length; i++) {
      final nodePaint =
          Paint()
            ..color = Theme.of(context).colorScheme.secondary.withAlpha(50);
      canvas.drawCircle(particlePositions[i], 5, nodePaint);
      for (int j = i + 1; j < particlePositions.length; j++) {
        if ((particlePositions[i] - particlePositions[j]).distance <
            maxDistance) {
          final linePaint =
              Paint()
                ..color = Theme.of(context).colorScheme.primary.withAlpha(50)
                ..strokeWidth = 2.5;
          canvas.drawLine(
            particlePositions[i],
            particlePositions[j],
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
