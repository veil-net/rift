import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MatrixRainBackground extends HookWidget {
  final Widget child;

  const MatrixRainBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final columns = useMemoized(() => List.generate(100, (_) => MatrixColumn()));
    final controller = useAnimationController(
      duration: const Duration(days: 365),
    )..repeat();

    useEffect(() {
      return null;
    }, []);

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: MatrixPainter(
              columns,
              primary: primary,
              secondary: secondary,
              repaint: controller,
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class MatrixColumn {
  double y = 0;
  double speed = Random().nextDouble() * 10 + 2;
  final _rand = Random();

  String getChar() => String.fromCharCode(0x30A0 + _rand.nextInt(96));
}

class MatrixPainter extends CustomPainter {
  final List<MatrixColumn> columns;
  final int charSize;
  final Color primary;
  final Color secondary;
  final Listenable? repaint;

  MatrixPainter(
    this.columns, {
    required this.primary,
    required this.secondary,
    this.charSize = 18,
    this.repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {

      // Set solid background color
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.transparent,
    );
    
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final cols = size.width ~/ charSize;

    for (int i = 0; i < cols; i++) {
      final col = columns[i % columns.length];
      double y = col.y;

      for (int j = 0; j < 20; j++) {
        final char = col.getChar();
        final isPrimary = j < 5; // stronger color for leading characters
        final color = isPrimary ? primary : secondary;

        textPainter.text = TextSpan(
          text: char,
          style: TextStyle(
            color: color.withAlpha(((1 - j / 20) * 255 * 0.25).round()),
            fontSize: charSize.toDouble(),
            fontFamily: 'monospace',
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(i * charSize.toDouble(), y));
        y -= charSize;
      }

      col.y += col.speed;
      if (col.y > size.height + 20 * charSize) col.y = 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
