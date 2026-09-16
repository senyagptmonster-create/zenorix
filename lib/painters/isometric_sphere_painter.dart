import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/zenorix_theme.dart';

class IsometricSpherePainter extends CustomPainter {
  final double animationValue; // 0.0 - 1.0 (breathing / rotating)
  final double focusProgress;  // 0.0 - 1.0 (elapsed session progress)
  final bool isActive;

  IsometricSpherePainter({
    required this.animationValue,
    required this.focusProgress,
    required this.isActive,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = min(size.width, size.height) * 0.38;
    final pulse = isActive ? sin(animationValue * 2 * pi) * 6 : 0.0;
    final r = baseRadius + pulse;

    // Concentric ambient aura rings
    final glowPaint = Paint()
      ..color = ZenorixTheme.accent.withValues(alpha: isActive ? 0.15 : 0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, r * 1.25, glowPaint);

    // Outer boundary sphere
    final outerPaint = Paint()
      ..color = ZenorixTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, r, outerPaint);

    // Progress arc along perimeter
    if (focusProgress > 0) {
      final progressPaint = Paint()
        ..color = ZenorixTheme.accentLight
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 4.0;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        -pi / 2,
        2 * pi * focusProgress,
        false,
        progressPaint,
      );
    }

    // Geodesic isometric latitude rings
    final latPaint = Paint()
      ..color = ZenorixTheme.accent.withValues(alpha: isActive ? 0.5 : 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 1; i <= 3; i++) {
      final latR = r * (i / 4.0);
      final ovalRect = Rect.fromCenter(
        center: center,
        width: r * 2,
        height: latR * 2,
      );
      canvas.drawOval(ovalRect, latPaint);
    }

    // Isometric longitudinal rings
    final angleShift = animationValue * pi;
    for (int i = 0; i < 4; i++) {
      final ang = (i * pi / 4) + angleShift;
      final xOffset = cos(ang) * (r * 0.8);
      final longRect = Rect.fromCenter(
        center: center,
        width: xOffset.abs().clamp(2.0, r * 2),
        height: r * 2,
      );
      canvas.drawOval(longRect, latPaint);
    }

    // Core central crystal point
    final corePaint = Paint()
      ..color = isActive ? ZenorixTheme.accentLight : ZenorixTheme.muted
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5.0, corePaint);
  }

  @override
  bool shouldRepaint(covariant IsometricSpherePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.focusProgress != focusProgress ||
        oldDelegate.isActive != isActive;
  }
}
